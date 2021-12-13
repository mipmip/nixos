{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    tmux
    wget
    gitFull
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
