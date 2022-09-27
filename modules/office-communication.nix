{ config, lib, pkgs, ... }:

{


  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    zoom-us
    teams
    slack
  ];
}
