{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gnome-secrets

    gthumb
    cinnamon.nemo

    baobab # GrandPerspective

    peek
    kooha

    evolution
    gnome.gnome-tweaks
    gnome.gpaste
    #gnome.gnome-screenshot
    mipmip_pkg.gnome-screenshot

    glib.dev
    glade
  ];
}


