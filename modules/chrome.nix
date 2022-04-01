{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unstable.firefox
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

}
