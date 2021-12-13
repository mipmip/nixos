{ lib, ... }:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{
  dconf.settings = {

    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/pim/.local/share/backgrounds/2021-09-14-22-31-31-johannes-plenio-CfKPPOgI-uI-unsplash.jpg";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [ (mkTuple [ "xkb" "us" ]) ];
      per-window = false;
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "grp:alt_shift_toggle" "lv3:ralt_switch" "compose:ralt" "caps:none" ];
    };

#    "org/gnome/desktop/interface" = {
#      clock-format = "24h";
#      clock-show-weekday = false;
#      cursor-theme = "Adwaita";
#      enable-animations = true;
#      enable-hot-corners = false;
#      font-antialiasing = "grayscale";
#      font-hinting = "none";
#      font-name = "Liberation Sans 10";
#      gtk-enable-primary-paste = false;
#      gtk-im-module = "gtk-im-context-simple";
#      gtk-theme = "Adwaita";
#      icon-theme = "Adwaita";
#      text-scaling-factor = 1.0;
#      toolbar-style = "text";
#    };
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      cycle-windows = [ "<Super>Escape" ];
      cycle-windows-backward = [ "<Shift><Super>Escape" ];
      maximize = [ "<Super>Up" ];
      minimize = [ "<Alt>F4" ];
      move-to-workspace-1 = [ "<Primary><Super>1" ];
      move-to-workspace-2 = [ "<Primary><Super>2" ];
      move-to-workspace-3 = [ "<Primary><Super>3" ];
      move-to-workspace-4 = [ "<Primary><Super>4" ];
      show-desktop = [ "F12" ];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "" ];
      switch-to-workspace-last = [];
      toggle-fullscreen = [ "<Super>f" ];
    };

    "wm/preferences" = {
      action-double-click-titlebar = "minimize";
      auto-raise = true;
      button-layout = "close:appmenu";
      focus-mode = "click";
      num-workspaces = 3;
      resize-with-right-button = false;
      theme = "Default";
      workspace-names = [ "1" "2" "3" "4" ];
    };

  };
}
