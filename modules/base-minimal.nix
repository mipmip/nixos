{ config, lib, pkgs, ... }:

{

  #environment.systemPackages = with pkgs; [
     #vim
     #git
     #tmux
     #zsh
     #curl
     #wget
     #gnumake
  #];

  environment.systemPackages = with pkgs; [
    tmux
    wget
    vim
    git
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
  ]
  else
  [
    curl
    gnumake
    zsh
  ]
  );
}
