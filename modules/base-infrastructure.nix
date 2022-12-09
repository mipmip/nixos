{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    ansible
    terraform

    # RUN GITHUB WORKFLOWS LOCALLY
    act

  ];
}
