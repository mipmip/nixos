{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #gnome.networkmanager-openvpn
    git-sync

    mipmip_pkg.cryptobox
    cryptsetup

    #NIX/GNOME/HOMEMANAGER
    dconf2nix

    newsflash


    #DSTP
    dstp

    #TRANSLATION TOOLS
    poedit
    intltool

    notify
    slop

    #VNC ADEVINTA
    remmina
    realvnc-vnc-viewer
    dog
  ];
}
