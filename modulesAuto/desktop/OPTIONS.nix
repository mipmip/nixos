{ lib, ... } : {

  options.nixos.desktop.enable = lib.mkEnableOption "enable desktop tools";
  options.nixos.desktopHyprland.enable = lib.mkEnableOption "enable hyprland tools";

}
