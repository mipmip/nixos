{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mipmip_pkg.mods
  ];
}



