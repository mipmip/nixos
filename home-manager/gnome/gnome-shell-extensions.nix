{ pkgs, config, ... }:


let
  mipmip_pkg = import (../../pkgs){};
in
  {

    home.packages = [
      mipmip_pkg.gnomeExt-gs-git
    ];
  }
