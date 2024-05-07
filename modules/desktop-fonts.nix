{ config, lib, pkgs, unstable, ... }:

let
  fontsList = with pkgs; [
    meslo-lg
    awesome
    dejavu_fonts
    open-sans
    inter
    rubik
    lato
    unstable.fira-code-nerdfont
    nerdfonts
  ];
in
{
  environment.systemPackages = fontsList;
  fonts.packages = fontsList;
}

