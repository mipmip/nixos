{ config, lib, ... }:

let
  cfg = config.roles.desktop;
in

{
  options.roles.desktop = {
    enable = lib.mkEnableOption "Configure as desktop computer";
  };

  config = lib.mkIf cfg.enable {
    programs.tmux.shortcut = "a";

    desktopConf.freedesktop.enable = true;
    desktopConf.myhotkeys.enable = true;
    desktopConf.gimp.enable = true;
    desktopConf.smug.enable = true;
    desktopConf.alacritty.enable = true;
    desktopConf.kitty.enable = true;
    desktopConf.firefox.enable = true;
    desktopConf.fonts.enable = true;
    desktopConf.obs.enable = true;
    desktopConf.gnome.enable = true;
  };
}
