{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
  ];
}

