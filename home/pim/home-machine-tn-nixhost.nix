{ lib, config, pkgs, ... }:

let
#  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  imports = [
    ./home-base-all.nix
  ];

  home.packages = [
    pkgs.neovim
    pkgs.gnumake
    pkgs.gcc
    pkgs.pkg-config

  ];


#  dconf.settings = {
#    "org/gnome/desktop/input-sources" = {
#      per-window = false;
#      sources = [ (mkTuple [ "xkb" "us" ]) ];
#      xkb-options = [
#
#        "altwin:swap_alt_win"
#
#        "grp:alt_shift_toggle"
#        "lv3:ralt_switch"
#        "compose:ralt"
#        "caps:none"];
#    };
#  };


}

