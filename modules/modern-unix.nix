{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    tldr
    cheat
    xh
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
  ]
  else
  [
  ]
  );
}
