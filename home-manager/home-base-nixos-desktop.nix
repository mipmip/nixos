{ config, pkgs, ... }:

{
  imports = [

    ./home-base-all.nix

    ./files-linux

    ./programs/firefox.nix
    ./programs/xdg.nix
    ./gnome

    /home/pim/nixos/private/adevinta/home-manager/files-main
  ];


}
