{ config, lib, pkgs, ... }:

{
  imports =
    [
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

  users.users.pim = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

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
  ];
  services.openssh.enable = true;
  services.tailscale.enable = true;

  system.stateVersion = "24.11";

}
