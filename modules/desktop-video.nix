{ config, lib, pkgs, pkgs-2311, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    openshot-qt
    x264
    ffmpeg
    vlc
    vhs

   pkgs-2311.obs-studio
   pkgs-2311.obs-studio-plugins.advanced-scene-switcher
   # obs-studio-plugins.input-overlay
  ];
}

