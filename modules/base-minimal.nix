{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
     vim
     git
     tmux
     zsh
     curl
     wget
     gnumake
  ];
}
