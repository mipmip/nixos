{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bat
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
  ]
  else
  [
  ]
  );
}
