{ config, lib, pkgs, ... }:

{

  services.onedrive.enable = true;

  environment.systemPackages = with pkgs; [
    pre-commit
    aws-mfa
    unstable.cloud-nuke
    awsweeper
    unstable.aws-nuke
    awscli2
    aws-vault
    drawio
    terraformer

    #RANDSTAD
    citrix_workspace
  ];
}

