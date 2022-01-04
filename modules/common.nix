{ config, lib, pkgs, ... }:

{

  #setxkbmap -option caps:none

  time.timeZone = "Europe/Amsterdam";
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.cron.enable = true;

  users.defaultUserShell = pkgs.zsh;

  services.lorri.enable = true;

  users.users.pim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "disk"];
  };

  users.users.guest = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
  };

}
