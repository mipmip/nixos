{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    librewolf
  ];

  #  environment.sessionVariables = {
  #    MOZ_ENABLE_WAYLAND = "1";
  #  };

}
