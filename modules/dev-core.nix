{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

    gh # GitHub Cli
    mipmip_pkg.fred # needed for linny
  ];
}

