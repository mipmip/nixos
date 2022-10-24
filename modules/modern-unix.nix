{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
    tldr
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
  ]
  else
  [
  ]
  );
}
