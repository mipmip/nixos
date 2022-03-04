{ config, lib, pkgs, ... }:

{

  environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1"
    };

  environment.systemPackages = with pkgs; [
    (vim_configurable.override { python = python3; })
  ];
}

