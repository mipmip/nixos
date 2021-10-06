{ config, pkgs, ... }:

{

  imports = [
    ../modules/base-minimal.nix
  ];

  environment.systemPackages = with pkgs; [
    htop
    mipmip_pkg.smug
  ];

  programs.zsh.enable = true;

  system.stateVersion = 4;
}

