{ config, inputs, system, pkgs, pkgs-share-preview-03, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../_roles/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # TODO NEEDED?
  virtualisation.libvirtd.enable = true;

  services.flatpak.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostName = "rodin";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "22.11";

  environment.systemPackages = with pkgs; [
    tmux
    pkgs-share-preview-03.share-preview
  ];

  services.pixiecore = {
    enable = true;
    openFirewall = true;
    dhcpNoBind = true;
    kernel = "https://boot.netboot.xyz";
  };


  networking.hosts = {
    "127.0.0.1" = [
      "ojs"
      "localhost"
    ];
    "3.122.241.107" = [
      "rrs-dev.healtcheck.internal"
      "rrs-acc.healtcheck.internal"
      "rrs-test.healtcheck.internal"
    ];
  };

}
