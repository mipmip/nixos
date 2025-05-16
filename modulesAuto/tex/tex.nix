{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.tex.enable {
    environment.systemPackages = with pkgs; [

      texlive.combined.scheme-full
      pandoc
      quarto
      librsvg
      jupyter


    ];
  };
}


