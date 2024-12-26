{ config, lib, pkgs, ... }:

{

  # TODO MOVE TO OWN SECTION
  nixpkgs.config.permittedInsecurePackages = [
    "libxls-1.6.2"
    "nix-2.15.3"
  ];

  environment.systemPackages = with pkgs; [
    gnumake
    gcc
    pkg-config
  ];
}
