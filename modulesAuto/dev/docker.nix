{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {

    virtualisation.docker.enable = config.services.docker.enable;

    environment.systemPackages = [
      pkgs.docker
      pkgs.docker-compose
    ];

  };
}
