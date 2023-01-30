{ config, pkgs, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {

    mipmip_pkg = import (../nur-pkgs) {
      inherit pkgs;
    };

  };

}
