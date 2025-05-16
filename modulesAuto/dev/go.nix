{ config, lib, pkgs, unstable, ... }:{

  config = lib.mkIf config.nixos.dev.enable {
    environment.systemPackages = with pkgs; [
      unstable.go
      gox
      goreleaser

    ];
  };
}

