{ inputs, ... } : {
  flake.modules.nixos.desktop-apps-dtp = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [

      # TODO which gimp shall we choose here?
      gimp
      gimp3-with-plugins

      inkscape-with-extensions
      feh
      emulsion-palette
      blender
      libreoffice
    ];

  };
}
