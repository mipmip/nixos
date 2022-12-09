{ config, lib, pkgs, unstable, ... }:

{

  services.onedrive.enable = true;

  environment.systemPackages = with pkgs; [

    # DIAGRAM
    drawio
    graphviz

    # 2FA
    authenticator

    # PASSWORDS
    gnupg
    pinentry
    pinentry-gtk2
    pass

    # AWS
    aws-mfa
    awsweeper
    #unstable.cloud-nuke
    #unstable.aws-nuke
    awscli2
    aws-vault


    # TERRAFORM
    terraform-docs
    terrascan
    terraformer
    tflint
    #unstable.terracognita

    # Swiss army knife for data
    sq

    #RANDSTAD
    #citrix_workspace

    #TRACKLIB
    wireguard-tools
    unstable.nodePackages.aws-cdk

    #ADEVINTA
    #unstable.globalprotect-openconnect
    #openconnect
    proxychains

    #VNC ADEVINTA
    remmina
    realvnc-vnc-viewer
    dog

  ];
}

