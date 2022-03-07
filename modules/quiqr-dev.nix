{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    mipmip_pkg.embgit
    ansible
  ]
  ++ (if pkgs.stdenv.isDarwin then
  [
  ]
  else
  [
  ]
  );
}
