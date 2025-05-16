{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    bat
    tldr

    # includes vidir
    moreutils

    # COMPRESS
    libarchive # Provides bsdtar and support for more archive formats
    zip
    unzip

    # Filemanager
    vifm
    wtf

    trash-cli


  ];
}
