{ config, lib, pkgs, ... }:

{

  time.timeZone = "Europe/Amsterdam";
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.cron.enable = true;

  users.defaultUserShell = pkgs.zsh;
  environment.variables = {
    EDITOR = "vim";
  };

  users.users.pim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  users.users.guest = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
  };

}
