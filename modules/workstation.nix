{ config, lib, pkgs, ... }:

{

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = false; # IF TRUE WAYLAND WILL BE USED

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  programs = {
    gpaste.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.systemPackages = with pkgs; [
     feh
     xclip
     weechat
     pandoc
     nfs-utils
     neofetch
     nextcloud-client
     neovim
     gimp
     gnome.gnome-tweaks
     ffmpeg
     docker
     inkscape
     blender
     libreoffice
     spotify
     tdesktop
     keepassxc
     firefox
     evolution
     alacritty
     cinnamon.nemo
     baobab # GrandPerspective
     go
     hugo # needed for linny
     appimage-run
     gnome.gpaste
     vimHugeX
     gitFull
  ];

}
