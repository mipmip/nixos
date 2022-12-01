{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openshot-qt
  ];
}

