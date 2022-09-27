{ config, lib, pkgs, ... }:

{

  (pkgs.slack.overrideAttrs (oldAttrs: rec {
    desktopItem = oldAttrs.desktopItem.overrideAttrs (desktopAttrs: {
      buildCommand =
        let
          oldExec = builtins.match ".*(\nExec=[^\n]+\n).*" desktopAttrs.buildCommand;
          matches = oldExec ++ oldTerminal;
          replacements = [ "\nExec=/my_exec\n" ];
        in
        assert oldExec != null && oldTerminal != null;
        builtins.replaceStrings matches replacements desktopAttrs.buildCommand;
      });
      postInstall = builtins.replaceStrings [ "${oldAttrs.desktopItem}" ] [ "${desktopItem}" ] oldAttrs.postInstall;
    }))


  environment.systemPackages = with pkgs; [
    zoom-us
    teams
    slack
  ];
}
