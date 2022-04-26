{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-javascript
      vim-jsx-pretty
    ];
    settings = {
      ignorecase = true;
    };

    extraConfig = ''
    '';
  };
}
