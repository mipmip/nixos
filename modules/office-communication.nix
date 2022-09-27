{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.slack.overrideAttrs (oldAttrs: rec {
      desktopItem = oldAttrs.desktopItem.overrideAttrs (desktopAttrs: {
        buildCommand =
          let
            oldExec = builtins.match ".*(\nExec=[^\n]+\n).*" desktopAttrs.buildCommand;
            matches = oldExec;
            replacements = [ "\nExec=/usr/bin/slack --enable-features=WebRTCPipeWireCapturer %U\n" ];
          in
          assert oldExec != null && oldTerminal != null;
          builtins.replaceStrings matches replacements desktopAttrs.buildCommand;
        });
        postInstall = builtins.replaceStrings [ "${oldAttrs.desktopItem}" ] [ "${desktopItem}" ] oldAttrs.postInstall;
      }))


      zoom-us
      teams
    ];
  }
