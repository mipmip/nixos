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

    #NIX/GNOME/HOMEMANAGER
    dconf2nix

    # HARDWARE UTILS
    dmidecode
    pciutils
    xlibs.xvinfo

    #PHOTO ORGANIZER
    shotwell

    #TRANSLATION TOOLS
    poedit
    intltool

    zettlr
    discord
  ];
}
