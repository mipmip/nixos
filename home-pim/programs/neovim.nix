{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-javascript
      vim-jsx-pretty
      lifepillar/vim-solarized8
      logico/typewriter-vim
      mipmip/vim-whitewriter', { 'branch': 'main' }

    ];

    extraConfig = ''
    '';
  };
}
