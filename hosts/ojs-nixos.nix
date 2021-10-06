{ config, pkgs, ... }:

{
  imports = [
    ../modules/base-minimal.nix
    ../modules/common.nix
    ../modules/common-pkg.nix
    ../modules/vim-large.nix
    ../modules/workstation.nix
    ../modules/virtualbox.nix
    ../modules/texlive.nix
    ../modules/fonts.nix
    ../modules/nfspiet.nix
    ../modules/peripherals_hurwenen.nix
    ../modules/nixos-utils.nix
    <nix-ld/modules/nix-ld.nix>
  ];

  networking.hostName = "ojs"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  networking.useDHCP = false;
  networking.interfaces.enp10s0.useDHCP = true;
  networking.interfaces.enp9s0.useDHCP = true;
  networking.interfaces.wlp0s29f7u5.useDHCP = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #KEYCHRON KEYBOARD SWAP FN KEY
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';

  system.stateVersion = "21.05"; # Did you read the comment?
}
