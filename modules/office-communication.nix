{ config, lib, pkgs, ... }:

{
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
  };

  environment.systemPackages = with pkgs; [

    # Enable slack screensharing in Wayland
    (pkgs.slack.overrideAttrs (oldAttrs: rec {
      installPhase = builtins.replaceStrings ["UseOzonePlatform"] ["UseOzonePlatform,WebRTCPipeWireCapturer"] oldAttrs.installPhase;
    }))

    zoom-us
    teams
  ];
}
