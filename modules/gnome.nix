{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-secrets
  ];
}


