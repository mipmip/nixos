{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    cryptsetup
  ];
}


