{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dia
    pencil
    gnome.networkmanager-openvpn
    youtube-dl
    tangram
    vscode

    zettlr
    discord
  ];
}
