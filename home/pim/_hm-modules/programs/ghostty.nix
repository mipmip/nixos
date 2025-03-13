{ config, lib, pkgs, ... }:

let
  cfg = config.desktopConf.ghostty;
in
  {

  options.desktopConf.ghostty = {
    enable = lib.mkEnableOption "Enable ghostty";
  };

  config = lib.mkIf cfg.enable {

    programs.ghostty = {
      enable = true;
      settings = {
        window-padding-x = 3;
        window-padding-y = 3;
        cursor-invert-fg-bg = true;
        mouse-hide-while-typing = true;
        gtk-tabs-location = "hidden";
      };
    };
  };
}
