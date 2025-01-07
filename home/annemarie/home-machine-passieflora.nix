{ lib, config, pkgs, username, homedir, ... }:

{
  fonts.fontconfig.enable = true;
  imports = [
    ./_roles/home-base-all.nix
    ./_roles/home-base-nixos-desktop.nix

    ../conf-desktop-linux/firefox.nix
    ../conf-desktop-linux/xdg.nix

    ../conf-gnome

  ];


  programs.home-manager.enable = true;
  home.username = username;
  home.homeDirectory = homedir;
  home.stateVersion = "22.05";


}
