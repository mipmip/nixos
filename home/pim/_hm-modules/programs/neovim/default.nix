{ config, pkgs,unstable, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

  programs.hm-ricing-mode.apps.neovim = {
    dest_dir = ".config/nvim";
    source_dir = "$HOME/nixos/home/pim/_hm-modules/programs/neovim/nvim";
    type = "symlink";
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

