{ config, pkgs,unstable, ... }:

{
  programs.neovim = {
    enable = true;
  };

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

  home.packages = [
    pkgs.gnumake
    pkgs.gcc
    pkgs.pkg-config
    pkgs.smug

    pkgs.nil
    pkgs.terraform-ls
    pkgs.silver-searcher
    pkgs.fzf
    pkgs.ripgrep
  ];
}

