{ config, pkgs,unstable, ... }:

{
  programs.neovim = {
    enable = true;
  };

  home.packages = [
    pkgs.nil
  ];
}
