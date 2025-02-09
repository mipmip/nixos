{ config, lib, pkgs, ... }:

{
  imports =
    [
      ../../modules/desktop-communication.nix
      ../../modules/nix-common.nix
      ./hardware-configuration.nix
      ./sleep.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";


  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "passieflora"; # Define your hostname.

  time.timeZone = "Europe/Amsterdam";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  programs.zsh.enable = true;

    nixos-boot = {
     enable  = true;
     theme = "grannyos";

     bgColor.red   = 0; # 0 - 255
     bgColor.green = 212; # 0 - 255
     bgColor.blue  = 255; # 0 - 255

    # If you want to make sure the theme is seen when your computer starts too fast
    # duration = 3; # in seconds
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    tmux
    git
    firefox

    home-manager

    gcc
    pkg-config
    gnumake

    gimp
    inkscape

    libreoffice
    hunspellDicts.nl_nl


    kitty
    alacritty

    gnome-tweaks
    gdm-settings
    gpaste

    seafile-client
  ];
  services.openssh.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "24.11";

}
