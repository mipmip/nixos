{ config, pkgs, ... }:

let
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    clear lock
    ! disable capslock
    ! remove Lock = Caps_Lock
  '';
in
  {
    imports =
      [
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

      # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";

      networking.hostName = "billquick";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  powerManagement.cpuFreqGovernor = "schedutil";

  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  system.stateVersion = "21.05";
}
