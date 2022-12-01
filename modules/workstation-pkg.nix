{ config, lib, pkgs, unstable, ... }:

{

  environment.systemPackages = with pkgs; [
    potrace
    pandoc
    neofetch
    neovim
    ffmpeg
    alacritty
    go_1_18
    gox
    goreleaser

    hugo # needed for linny
    mipmip_pkg.fred # needed for linny
    mipmip_pkg.mip # Markdown in Preview

    vimHugeX
    #vim_configurable

    gitFull
    #github-desktop
    gh # GitHub Cli

    zathura
    pdftk
    x264

    nextcloud-client

    gimp
    unstable.inkscape-with-extensions
    blender
    libreoffice

    spotify

    tdesktop

    keepassxc
    bitwarden

    feh
    xclip
    nfs-utils
    appimage-run
    vlc
    protonmail-bridge

    whatsapp-for-linux

  ];
}
