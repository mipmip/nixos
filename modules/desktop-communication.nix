{ config, lib, pkgs, unstable, ... }:

{
  #  environment.sessionVariables = {
  #    NIXOS_OZONE_WL = "1";
  #  };

  environment.systemPackages = with pkgs; [

    # Enable slack screensharing in Wayland
    #(unstable.slack.overrideAttrs (oldAttrs: rec {
    #  installPhase = builtins.replaceStrings ["UseOzonePlatform" "--ozone-platform=wayland"] ["UseOzonePlatform,WebRTCPipeWireCapturer" ""] oldAttrs.installPhase;
    #}))

    unstable.slack

    #msmtp
#    unstable.whatsapp-for-linux
    unstable.signal-desktop
    unstable.flare-signal

    tdesktop
    v4l-utils

    zoom-us
    unstable.rustdesk
    # teams

#    unstable.srain #IRC
#    unstable.tuba # Mastodon

#    discord



    unstable.himalaya
  ];
}
