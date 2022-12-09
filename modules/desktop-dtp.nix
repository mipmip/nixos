{ config, lib, pkgs, unstable, ... }:

{

  environment.systemPackages = with pkgs; [

    # PDF
    zathura
    pdftk


    gimp
    unstable.inkscape-with-extensions
    feh

    blender

    libreoffice

    nextcloud-client
    spotify

  ];
}
