{ config, lib, pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    openshot-qt
    x264
    ffmpeg
    vlc
    vhs

   obs-studio
   obs-studio-plugins.advanced-scene-switcher
   # obs-studio-plugins.input-overlay
  ];
}

