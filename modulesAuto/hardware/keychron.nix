{ lib, config, pkgs, ... }:

{

  options.nixos.hardware.keychron.enable = lib.mkEnableOption "enable keychron keyboard settings";

  config = lib.mkIf config.nixos.hardware.keychron.enable {

    #KEYCHRON KEYBOARD SWAP FN KEY
    boot.extraModprobeConfig = ''
    options hid_apple fnmode=2
    '';

    boot.kernelModules = [ "hid-apple"  ];

    #NIEUWE POGING
    boot.kernelParams = [
      "hid_apple.fnmode=2"
    ];

  };
}

