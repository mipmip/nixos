{ config, pkgs, ... }:

{
  imports =
    [
      ./shared-configuration.nix
      ./hosts/billquick-darwin.nix
    ];
}
