{ config, lib, swapAltWin, ... }:

let
  cfg = config.roles.desktop;
in

{
  options.roles.desktop = {
    enable = lib.mkEnableOption "Configure as desktop computer";
  };
  config = lib.mkIf cfg.enable {
    desktopConf.gnome.enable = true;
  };
}
