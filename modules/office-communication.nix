{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.slack.overrideAttrs (oldAttrs: rec {
      installPhase = builtins.replaceStrings ["UseOzonePlatform"] ["UseOzonePlatform,WebRTCPipeWireCapturer"] oldAttrs.installPhase;
    }))

    zoom-us
    teams
  ];
}
