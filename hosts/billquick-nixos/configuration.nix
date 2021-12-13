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
        ../../shared-configuration.nix
        ../../modules/base-minimal.nix
        ../../modules/common.nix
        ../../modules/common-pkg.nix
#        ../../modules/home-manager.nix
        ../../modules/crystal-dev.nix
        ../../modules/poppygo-dev.nix
        ../../modules/vim-large.nix
        ../../modules/workstation.nix
        ../../modules/workstation-pkg.nix
        ../../modules/fonts.nix
        ../../modules/explore-pkg.nix
        ../../modules/nfspiet.nix
        ../../modules/peripherals_hurwenen.nix
        ../../modules/nixos-utils.nix
    #   ../../modules/virtualbox.nix
    #   ../../modules/texlive.nix
    #    <nix-ld/modules/nix-ld.nix>

    ];

    services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";

    networking.hostName = "billquick";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.interfaces.wlp0s20u2.useDHCP = true;

  #KEYCHRON KEYBOARD SWAP FN KEY
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid-apple"  ];



  system.stateVersion = "21.05"; # Did you read the comment?



}
