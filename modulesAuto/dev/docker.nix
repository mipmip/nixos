{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {

    virtualisation.docker.enable = true;

    environment.systemPackages = [
      pkgs.docker
      pkgs.docker-compose
    ];

  };
}
