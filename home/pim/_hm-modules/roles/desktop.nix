{ config, lib, ... }:

let
  cfg = config.roles.desktop;
in

{
    options.roles.desktop = {
      enable = lib.mkEnableOption "Configure as desktop computer";
    };

    config = lib.mkIf cfg.enable {
#      desktopConf.gimp.enable = true;
      desktopConf.alacritty.enable = true;
#      desktopConf.terminals.enable = true;
#      desktopConf.firefox.enable = true;
#      desktopConf.fonts.enable = true;
#      desktopConf.obs.enable = true;
#      desktopConf.xdg.enable = true;
#      desktopConf.gnome.enable = true;
      

  };
}
