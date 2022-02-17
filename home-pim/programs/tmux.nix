{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    newSession = true;
    shortcut = "a";
    plugins = [
      pkgs.tmuxPlugins.urlview
    ];

    extraConfig = ''
      if '[ -f ~/.tmux/gpakosz.cf ]' 'source ~/.tmux/gpakosz.cf'
      run 'cat ~/.tmux/gpakosz.sh | sh -s _apply_configuration'
    '';
  };
}