{
  programs.tmux = {
    enable = true;
    programs.tmux.extraConfig = ''
      source-file ~/.tmux/10-main.conf
      source-file ~/.tmux/20-bind_keys.conf
      if '[ -f ~/.i-am-desktop-machine ]' 'source ~/.tmux/30-desktop.conf'
      if '[ -f ~/.tmux/gpakosz.cf ]' 'source ~/.tmux/gpakosz.cf'
      run 'cat ~/.tmux/gpakosz.sh | sh -s _apply_configuration'
    ''
  };
}
