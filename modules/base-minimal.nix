{ config, lib, pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;

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
