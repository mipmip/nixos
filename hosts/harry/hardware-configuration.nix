{ config, lib, pkgs, modulesPath, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
