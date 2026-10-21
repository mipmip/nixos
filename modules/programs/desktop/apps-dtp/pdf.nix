{ inputs, ... } : {

  flake.modules.nixos.desktop-apps-dtp = { config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [

      # Viewers
      zathura

      pdftk
      pdfarranger
      ghostscript
    ];

  };
}

