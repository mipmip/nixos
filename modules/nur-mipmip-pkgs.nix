{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {

    mipmip_pkg = import (../nur-mipmip-pkgs) {
      inherit pkgs;
    };

  };

}
