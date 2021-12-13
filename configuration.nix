{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./shared-configuration.nix
      ./hosts/billquick-nixos.nix
    ];
}
