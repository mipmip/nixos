{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openshot-qt
    x264
    ffmpeg
    vlc
    vhs

   # obs-studio
   # obs-studio-plugins.input-overlay
  ];
}

