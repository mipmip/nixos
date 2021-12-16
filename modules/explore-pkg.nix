{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dia
    pencil
    gnome.networkmanager-openvpn
    youtube-dl
    tangram
    vscode
    kitty
    git-sync
    dconf2nix

    # HARDWARE UTILS
    dmidecode
    pciutils
    xlibs.xvinfo

    zettlr
    discord
  ];
}
