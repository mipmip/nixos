{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-javascript
      vim-jsx-pretty
      NeoSolarized
      lifepillar/vim-solarized8
      logico/typewriter-vim
      mipmip/vim-whitewriter', { 'branch': 'main' }

    ];

    extraConfig = ''
    '';
  };
}
