# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, inputs, system, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

      ../../modules/base-common.nix
      ../../modules/base-docker.nix
      ../../modules/base-git.nix
      ../../modules/base-vpn.nix
      ../../modules/base-hardware.nix
      ../../modules/base-infrastructure.nix
      ../../modules/base-modern-unix.nix
      ../../modules/base-tex.nix
      ../../modules/base-tmux.nix
      ../../modules/base-vim.nix

#      ../../modules/desktop-chrome.nix
#      ../../modules/desktop-communication.nix
      ../../modules/desktop-dtp.nix
      ../../modules/desktop-firefox.nix
      ../../modules/desktop-dev.nix
      ../../modules/desktop-fonts.nix
      ../../modules/desktop-gnome.nix
      ../../modules/desktop-st.nix
      ../../modules/desktop-video.nix
      ../../modules/desktop-virtualbox.nix
      ../../modules/desktop-security.nix

      ../../modules/dev-crystal.nix
      ../../modules/dev-go.nix
      ../../modules/dev-technative.nix

      ../../modules/explore-pkg.nix

      ../../modules/hardware-kbd-keychron.nix
      ../../modules/hardware-krd_disable-caps.nix
      ../../modules/hardware-printers.nix

      ../../modules/nix-comma.nix
      ../../modules/nix-common.nix
      ../../modules/nix-desktop.nix
      ../../modules/nix-home-manager-global.nix
      ../../modules/nix-utils.nix
      ../../modules/nur-my-pkgs.nix



    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
         experimental-features = nix-command flakes
    '';
  };


  # enable the nvidia driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  networking.hostName = "rodin"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  networking.firewall.enable = false;

  system.stateVersion = "22.11"; # Did you read the comment?

}
