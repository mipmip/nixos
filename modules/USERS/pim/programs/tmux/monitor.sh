#!/usr/bin/env bash
# The prefix + M monitoring popup: nbping and updo side by side.
#
# Unlike the float, the session behind this popup is not killed on close. The
# point of the popup is that both tools have been running while you were not
# looking; a tool restarted on every open shows an empty table and an uptime
# figure computed over four seconds, which reads as an answer and is not one.
#
#   first open            closed                 reopened
#   +------------+        +------------+         +------------+
#   |nbping|updo |  the   |nbping|updo |  the    |nbping|updo |
#   | .... | ... |  popup | still       | popup  | ..... |....|
#   +------------+  goes  | running     | is     +------------+
#    popup               +-------------+  back    popup
#
# Which half of the toggle runs is decided in the bind, not here: the pressing
# client's session is what tells open from close, and run-shell -b has no
# client. See binds.nix.
#
# NBPING, UPDO, HOSTS and UPDO_CONFIG are set by the Nix wrapper above this
# file, so the store paths and the nebula registry arrive as plain variables.

set -u

SESS=_nbmon

# Pane identity is positional: first pane nbping, second updo. remain-on-exit
# keeps a pane that has exited in its slot, so the two positions hold for the
# life of the session.
pane_command() {
  case "$1" in
    1) printf '%s -v table -i 3 %s' "$NBPING" "$HOSTS" ;;
    2) printf '%s -C %s' "$UPDO" "$UPDO_CONFIG" ;;
    *) return 1 ;;
  esac
}

pane_count() {
  tmux list-panes -t "=$SESS:" -F '#{pane_id}' 2>/dev/null | grep -c .
}

# Two empty panes with the session options already set, then both filled. The
# skeleton is built before the tools start so that remain-on-exit is in force
# by the time either can exit: a tool that fails immediately would otherwise
# take its pane, and with it the session, down before the option landed.
build() {
  local win n id

  win=$(tmux new-session -d -s "$SESS" -n monitor -P -F '#{window_id}')
  tmux set -w -t "$win" remain-on-exit on
  # No "=" prefix: set-option rejects the exact-match form on a session name.
  tmux set -t "$SESS" status off

  tmux split-window -h -t "$win"
  tmux select-layout -t "$win" even-horizontal

  n=1
  while read -r id; do
    tmux respawn-pane -k -t "$id" "$(pane_command "$n")"
    n=$(( n + 1 ))
  done < <(tmux list-panes -t "$win" -F '#{pane_id}')
}

# Only panes tmux reports as dead are respawned. A live pane is left strictly
# alone, so quitting updo never costs nbping the history it has collected.
revive() {
  local n id dead
  n=1
  while read -r id dead; do
    [ "$dead" = 1 ] && tmux respawn-pane -t "$id" "$(pane_command "$n")"
    n=$(( n + 1 ))
  done < <(tmux list-panes -t "=$SESS:" -F '#{pane_id} #{pane_dead}')
}

ensure() {
  if ! tmux has-session -t "=$SESS" 2>/dev/null; then
    build
    return 0
  fi

  # A pane killed outright, rather than exited, breaks the positional identity
  # the revive pass depends on. Rebuilding loses the surviving tool's history,
  # which is the lesser harm and only reachable by killing a pane by hand.
  if [ "$(pane_count)" -ne 2 ]; then
    tmux kill-session -t "=$SESS"
    build
    return 0
  fi

  revive
}

open() {
  local client

  # Read before anything else: display-popup has to target the outer client,
  # and run-shell -b has already left it by the time the popup opens.
  client=$(tmux display -p '#{client_tty}')

  ensure

  # Near the full terminal, because nbping's table and updo's table each get
  # half of it. The picker popups are 60% to 90% wide, which would leave each
  # tool under half of that.
  #
  # The target is quoted inside the -E string. tmux hands that string to a
  # shell, and zsh reads a leading `=` as its own filename expansion: unquoted,
  # `-t =_nbmon` reaches the shell as "_nbmon not found" and the popup closes
  # again the moment it opens.
  tmux display-popup \
    -c "$client" \
    -w 98% -h 85% \
    -b rounded \
    -E "TMUX= tmux attach -t '=$SESS'"
}

case "${1:-open}" in
  open) open ;;
  ensure) ensure ;;
  *)
    tmux display-message "nebula-monitor: unknown command ${1}"
    exit 2
    ;;
esac
