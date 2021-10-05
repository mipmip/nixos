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
  services.printing.drivers = [
    #pkgs.mipmip_pkg.hl4150cdn
    #(pkgs.callPackage ../printers/hll2395dw-cups.nix {})
    (pkgs.callPackage ../printers/hl2360.nix {})
    (pkgs.callPackage ../pkgs/hl4150cdn/default.nix {})
  ];

  # Enable automatic discovery of the printer from other Linux systems with avahi running.
  # services.avahi.enable = true;
  # services.avahi.publish.enable = true;
  # services.avahi.publish.userServices = true;
  # services.avahi.nssmdns = true;

  # services.printing.browsing = true;
  # services.printing.listenAddresses = [ "*:631" ]; # Not 100% sure this is needed and you might want to restrict to the local network
  # services.printing.allowFrom = [ "all" ]; # this gives access to anyone on the interface you might want to limit it see the official documentation
  # services.printing.defaultShared = true; # If you want

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
