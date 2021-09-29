{ config, lib, pkgs, ... }:

{

  # Define a user account. Don't forget to set a password with ‘passwd’.
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
     fzf
     vifm
  ];

}
