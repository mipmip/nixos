{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #gnome.networkmanager-openvpn

    mipmip_pkg.cryptobox
    cryptsetup

    #NIX/GNOME/HOMEMANAGER
    dconf2nix




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
