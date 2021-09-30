{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./hosts/ojs.nix
    ];
}
