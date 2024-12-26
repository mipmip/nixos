{ config, pkgs,unstable, ... }:

{
  programs.neovim = {
    enable = true;
  };


  home.packages = [
    pkgs.gnumake
    pkgs.gcc
    pkgs.pkg-config
    pkgs.gum
    pkgs.granted
    pkgs.smug

    pkgs.nil
    pkgs.terraform-ls
    pkgs.silver-searcher
    pkgs.fzf
    pkgs.ripgrep
  ];
}
