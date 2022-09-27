{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.slack.overrideAttrs (oldAttrs: rec {
      installPhase = builtins.replaceStrings [""] ["i"] oldAttrs.installPhase
    }))


    zoom-us
    teams
  ];
}
