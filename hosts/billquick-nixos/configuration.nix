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
        ../../modules/crystal-dev.nix
        ../../modules/quiqr-dev.nix
        ../../modules/vim-large.nix
        ../../modules/workstation.nix
        ../../modules/workstation-pkg.nix
        ../../modules/fonts.nix
        ../../modules/firefox.nix
        ../../modules/explore-pkg.nix
        ../../modules/st.nix
        ../../modules/nfspiet.nix
        ../../modules/peripherals_hurwenen.nix
        ../../modules/nixos-utils.nix
        ../../modules/virtualbox.nix
        ../../modules/since-nixos-21-05.nix
        ../../modules/texlive.nix
        ../../modules/quiqr-dev.nix
    ];

    services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";

    networking.hostName = "billquick";

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # the default governor constantly runs all cores on max frequency
  # schedutil will run at a lower frequency and boost when needed
  powerManagement.cpuFreqGovernor = "schedutil";

  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;
  networking.useDHCP = false;
  networking.interfaces.wlp0s20u2.useDHCP = true;

  #KEYCHRON KEYBOARD SWAP FN KEY
  boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
  '';
  boot.kernelModules = [ "hid-apple"  ];

#  services.xserver.videoDrivers = [
#    "nvidia"
#    "amdgpu"
#    "radeon"
#    "nouveau"
#    "modesetting"
#    "fbdev"
#  ];
#
#  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
#  boot.kernelPackages = pkgs.linuxPackages_5_4;

  system.stateVersion = "21.05"; # Did you read the comment?



}
