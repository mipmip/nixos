{ config, lib, pkgs, ... }:

{

  time.timeZone = "Europe/Amsterdam";
  nixpkgs.config.allowUnfree = true;
  services.openssh.enable = true;

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

  environment.systemPackages = with pkgs; [
    binutils
    htop
    nix-index
    gettext
    gcc
    ruby
    silver-searcher
    python3
    fzf
    vifm
    apg
    bind.dnsutils
    wtf
  ];
}
