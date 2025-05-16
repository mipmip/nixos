{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {
    environment.systemPackages = with pkgs; [
      crystal
      shards
      crystal2nix
      #mipmip_pkg.crelease replace is needed
    ];
  };
}

