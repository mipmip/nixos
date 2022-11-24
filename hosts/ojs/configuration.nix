{ config, inputs, system, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/nur-mipmip-pkgs.nix

    ../../modules/base-minimal.nix
    ../../modules/common.nix
    ../../modules/common-pkg.nix
    ../../modules/modern-unix.nix
    ../../modules/dev-crystal.nix
    ../../modules/dev-quiqr.nix
    ../../modules/dev-technative.nix
    ../../modules/vim-large.nix
    ../../modules/workstation.nix
    ../../modules/video.nix
    ../../modules/docker.nix
    ../../modules/virtualbox.nix

    ../../modules/workstation-pkg.nix

    ../../modules/home-manager-global.nix

    ../../modules/texlive.nix
    ../../modules/fonts.nix
    ../../modules/st.nix
    ../../modules/terminal.nix
    ../../modules/office-communication.nix
    ../../modules/browser-firefox.nix
    ../../modules/browser-chrome.nix
    ../../modules/peripherals_hurwenen.nix
    ../../modules/nixos-utils.nix
    ../../modules/explore-pkg.nix
    ../../modules/hardware.nix

    ../../modules/keyboard_keychron.nix
    ../../modules/keyboard_disable_caps.nix
    ../../modules/network_nfspiet.nix
    #../../modules/network_wireguard.nix
    ../../modules/network_wireguard_quick.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
            experimental-features = nix-command flakes
    '';
  };

  networking.hosts = {
    "127.0.0.1" = [
      "ojs"
      "localhost"
    ];
    "10.57.194.13" = [
      "jenkins.prod.ki.ecg.so"
    ];
  };

  networking.hostName = "ojs";
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  systemd.services.NetworkManager-wait-online.enable = false;

  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.enp10s0.useDHCP = true;
  networking.interfaces.enp9s0.useDHCP = true;
  networking.interfaces.wlp0s29f7u5.useDHCP = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.extraModulePackages = [
    config.boot.kernelPackages.broadcom_sta
  ];

  system.stateVersion = "22.05";
}
