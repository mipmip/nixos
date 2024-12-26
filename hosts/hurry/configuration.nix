{ config, inputs, system, pkgs, ... }:

let
  user = "pim";
  password = "guest";
  SSID = "ZyXEL11767C";
  SSIDpassword = "ED4A6EDA7B4D";
  interface = "wlan0";
  hostname = "hurry";
  smtpPasswd = "";
  smtpUser = "";
in {

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  networking = {
    firewall.enable = false;
    hostName = hostname;
    wireless = {
      enable = true;
      networks."${SSID}".psk = SSIDpassword;
      interfaces = [ interface ];
    };
  };

  environment.systemPackages = with pkgs; [ 
    home-manager
	vim
	tmux
	git
        htop
        libraspberrypi
        raspberrypi-eeprom
  ];

  services.openssh.enable = true;
  services.tailscale.enable = true;

  services.vaultwarden.enable = true;
  services.vaultwarden.backupDir = "/var/lib/backups/vaultwarden";
  services.vaultwarden.config = {
	  signupsAllowed = false;
	  invitationsAllowed = false;
	  #domain = "http://${serverName}";
	  rocketPort = 8000;
	  websocketEnabled = true;
  };

  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "esphome"
      "met"
      "radio_browser"
    ];
    
    customComponents = with pkgs.home-assistant-custom-components; [
      prometheus_sensor
      #"system_health"
      localtuya
      #"pushover"
      #"telegram"
      #"timer"
      #"tado"
      #"systemmonitor"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };

  users = {
    mutableUsers = true;
    users."${user}" = {
      isNormalUser = true;
      #password = password;
      extraGroups = [ "wheel" ];
    };
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix
    ../../modules/base-core.nix
    #../../modules/nix-agenix.nix
    ../../modules/nix-common.nix
    ../../modules/nix-home-manager-global.nix
  ];

  nix = {
    package = pkgs.nixVersions.stable;
    settings.trusted-substituters = [
      "http://attic.np-tools.technative.cloud:8080/jeroen"
    ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
