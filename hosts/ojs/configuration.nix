{ config, inputs, system, pkgs, ... }:

{
  imports = [

    ./hardware-configuration.nix
    ../_roles/desktop.nix
    ../_roles/dev-machine.nix
    #../../modules/nix-samba.nix
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
       experimental-features = nix-command flakes
    '';
  };

  networking.hostName = "ojs";
  networking.firewall.enable = false;
  networking.networkmanager.enable = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "22.05";
}
