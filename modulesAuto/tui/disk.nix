{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    duf
    libarchive # Provides bsdtar and support for more archive formats
    pmount # For mounting disks
    udisks # For mounting disks
    gptfdisk
  ];
}
