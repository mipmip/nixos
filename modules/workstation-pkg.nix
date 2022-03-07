{ config, lib, pkgs, ... }:

{


  environment.systemPackages = with pkgs; [
    potrace
    weechat
    pandoc
    neofetch
    neovim
    ffmpeg
    alacritty
    go
    gox
    goreleaser

    hugo # needed for linny
    mipmip_pkg.fred # needed for linny

    vimHugeX
    gitFull
  ]

  ++ (if pkgs.stdenv.isDarwin then [
     iterm2
  ]
  else [
    zathura

    docker
    docker-compose
    nextcloud-client
    gimp
    inkscape-with-extensions
    blender
    libreoffice
    spotify
    unstable.tdesktop
    keepassxc
    firefox

    gthumb
    peek
    cinnamon.nemo
    evolution
    feh
    xclip
    nfs-utils
    gnome.gnome-tweaks
    baobab # GrandPerspective
    appimage-run
    unstable.gnome.gpaste
    glib.dev
    glade
  ]);

}
