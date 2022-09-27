{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    (pkgs.slack.overrideAttrs (oldAttrs: rec {


        installPhase = old.installPhase + ''
            echo "${(import ./companion-cube.cow)}" > $out/share/cows/companion-cube.cow
              '';

      }))


      zoom-us
      teams
    ];
  }
