{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.hyprland.enable {

    programs = {
      dconf.enable = true;
      xwayland.enable = true;
    };

    security.polkit.enable = true;

    services.displayManager.sessionPackages = [ pkgs.hyprland ];

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        #pkgs.xdg-desktop-portal-gtk
      ];
    };

    # Hint Electon apps to use wayland
    #  environment.sessionVariables = {
    #    NIXOS_OZONE_WL = "1";
    #  };

    environment.systemPackages = with pkgs; [
      waybar
      hyprland
      wofi
      swww # for wallpapers
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
      xwayland
    ];


  };
}
