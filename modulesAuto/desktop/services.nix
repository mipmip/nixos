{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.desktop.enable {
    services.xserver.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # IF TRUE WAYLAND WILL BE USED
    services.xserver.displayManager.gdm.enable = true;
    services.displayManager.defaultSession = "gnome";

    services.flatpak.enable = true;

    # Configure keymap in X11
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.options = "caps:none,terminate:ctrl_alt_bks";
  };
}


