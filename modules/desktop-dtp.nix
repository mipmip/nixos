{ config, lib, pkgs, unstable, ... }:

{

  environment.systemPackages = with pkgs; [

    # PDF
    #zathura
    pdftk
    pdfarranger
    ghostscript
    #paperwork # could replace papermerge

    gimp
    unstable.inkscape-with-extensions
    krita

    #nixpkgs-inkscape13.inkscape
    feh
    #swappy

    #emulsion-palette

    blender

    libreoffice

    #nextcloud-client
    seafile-client
    #syncthing

  ];
}
