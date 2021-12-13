{ config, pkgs, ... }:

{

  nixpkgs.config.packageOverrides = pkgs: {

    unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };

    mipmip_pkg = import (./pkgs) {
      inherit pkgs;
    };
  };

}

