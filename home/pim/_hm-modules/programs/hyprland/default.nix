{
  home.file = {
    ".config/hypr" = {
      source = ./hypr;
      recursive = true;
    };
  };

  programs.hm-ricing-mode.apps.hypr = {
    dest_dir = ".config/hypr";
    source_dir = "$HOME/nixos/home/pim/_hm-modules/programs/hyprland/hypr";
    type = "symlink";
  };
}
