{ config, lib, pkgs, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
  cfg = config.desktopConf;
in

{


    #  options.desktopConf.gnome = {
    #    swapaltwin = lib.mkEnableOption "Swap Win or Mac Key";
    #  };

  config = lib.mkIf cfg.gnome.enable
    {

    dconf.settings = {

      "org/gnome/desktop/input-sources" = {
        mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
        per-window = false;
        sources = [ (mkTuple [ "xkb" "us" ]) ];
        xkb-options = [
          "grp:alt_shift_toggle"
          "lv3:ralt_switch"
          "compose:ralt"
            #          "caps:none"
          ];
          #++ lib.mkIf cfg.gnome.swap_alt_win [ "altwin:swap_alt_win" ];

      };

    };


  };
}
