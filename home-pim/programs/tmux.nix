{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    newSession = true;
    shortcut = "a";
    historyLimit = 5000
    plugins = [
      pkgs.tmuxPlugins.urlview
    ];

    extraConfig = ''
      set -s escape-time 10                     # faster command sequences
      set -sg repeat-time 600                   # increase repeat timeout

      set -s focus-events on


      if '[ -f ~/.tmux/gpakosz.cf ]' 'source ~/.tmux/gpakosz.cf'
      run 'cat ~/.tmux/gpakosz.sh | sh -s _apply_configuration'
    '';
  };
}
