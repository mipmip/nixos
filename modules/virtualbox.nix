{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    virtualbox # only on baremetal
  ];

}

