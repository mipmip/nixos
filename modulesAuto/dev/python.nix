{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {
    environment.systemPackages = with pkgs; [

      uv
      python3Full
      python3Packages.pip
      python3Packages.setuptools
      python3Packages.requests
      python3Packages.numpy

    ];
  };
}

