{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nur-mipmip-pkgs.nix
    ../../modules/base-minimal.nix
    ../../modules/common.nix
    ../../modules/common-pkg.nix
    ../../modules/dev-quiqr.nix
    ../../modules/dev-technative.nix
    ../../modules/office-communication.nix
    ../../modules/docker.nix
    ../../modules/modern-unix.nix
    ../../modules/vim-large.nix
    ../../modules/workstation.nix
    ../../modules/workstation-pkg.nix
    ../../modules/fonts.nix
    ../../modules/browser-firefox.nix
    ../../modules/browser-chrome.nix
    ../../modules/explore-pkg.nix
    ../../modules/st.nix
    ../../modules/nfspiet.nix
    ../../modules/peripherals_hurwenen.nix
    ../../modules/nixos-utils.nix
    ../../modules/texlive.nix
    ../../modules/keyboard_keychron.nix
    ../../modules/keyboard_disable_caps.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
            experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.cpuFreqGovernor = "schedutil";

  networking.hostName = "billquick";

  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  system.stateVersion = "22.05";
}
