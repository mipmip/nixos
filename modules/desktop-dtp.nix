{ config, lib, pkgs, unstable, ... }:

{

  environment.systemPackages = with pkgs; [

    # PDF
    zathura
    pdftk


    gimp
    inkscape-with-extensions
    feh

    blender

    libreoffice

    nextcloud-client
    spotify

  ];
}
