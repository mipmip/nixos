{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    bat
    tldr
    cheat
    httpie
    xh
    duf
    dstp # Run common networking tests against your site
  ];
}
