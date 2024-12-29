{ config, lib, pkgs, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
  cfg = config.desktopConf.gnome;
in

{

    #  options.desktopConf.gnome = {
    #    swapaltwin = lib.mkEnableOption "Swap Win or Mac Key";
    #  };

  config = lib.mkIf cfg.enable
    {

    dconf.settings = {

      # TODO CHECK OVERRIDE STRATEGY ON LEGO1
      "org/gnome/desktop/input-sources" = {
        mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
        per-window = false;
        sources = [ (mkTuple [ "xkb" "us" ]) ];
        xkb-options = [
          #"altwin:swap_alt_win" #set on rodin
          "grp:alt_shift_toggle"
          "lv3:ralt_switch"
          "compose:ralt"
          "caps:none"];
      };

    };


  };
}
