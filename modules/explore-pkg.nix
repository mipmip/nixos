{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome.networkmanager-openvpn
    youtube-dl
    tangram
    kitty
    git-sync

    nodePackages.livedown

    nodePackages.node2nix

    mipmip_pkg.cryptobox
    cryptsetup

    #NIX/GNOME/HOMEMANAGER
    dconf2nix

    # HARDWARE UTILS
    dmidecode
    pciutils

    newsflash

    # tmux
    urlview

    kooha
    zoom-us
    #teams

    #DSTP
    dstp

    #TRANSLATION TOOLS
    poedit
    intltool
    notify
    slop
  ];
}
