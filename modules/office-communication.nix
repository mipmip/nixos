{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.slack.overrideAttrs (oldAttrs: rec {
      }))


      zoom-us
      teams
    ];
  }
