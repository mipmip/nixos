{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ansible
    terraform
    act
  ];
}
