{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    tldr
    cheat
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
  ]
  else
  [
  ]
  );
}
