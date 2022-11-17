{ config, lib, pkgs, unstable, ... }:

{

  services.onedrive.enable = true;

  services.globalprotect = {
    enable = true;
    #csdWrapper = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
    csdWrapper = "/etc/secrets/hipreport-adevinta.sh";
#    settings = {
#      vpn.advgo.net = {
#        openconnect-args="--csd-wrapper=/etc/secrets/hipreport-adevinta.sh --dump-http-traffic --useragent='PAN GlobalProtect/5.2.11-10 (Apple Mac OS X 12.4.0)' --version-string='5.2.11-10' --os=mac-intel";
#      };
#    };
  };

  programs.proxychains.enable = true;
  programs.proxychains.proxies = {
    myproxy = {
      type = "socks4";
      host = "127.0.0.1";
      port = 1080;
    };
  };

  environment.systemPackages = with pkgs; [
    pre-commit
    aws-mfa
    #unstable.cloud-nuke
    awsweeper
    #unstable.aws-nuke
    awscli2
    aws-vault
    drawio
    terraformer
    authenticator
    git-crypt
    gnupg
    pinentry
    pass
    pinentry-gtk2
    graphviz

    #unstable.terracognita

    sq
    terraform-docs
    terrascan
    tflint

    #RANDSTAD
    #citrix_workspace

    #TRACKLIB
    wireguard-tools

    #ADEVINTA
    unstable.globalprotect-openconnect
    openconnect
    proxychains

  ];
}

