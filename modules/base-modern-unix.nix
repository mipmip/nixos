{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neofetch
    tldr
    cheat
    httpie
    xh

    # disk
    duf

    dstp # Run common networking tests against your site

    # modern cat
    dog
    bat
  ];
}
