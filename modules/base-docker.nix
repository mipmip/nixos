{ config, lib, pkgs, ... }:

with lib;

{
  options = {
    services.docker.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Docker service.";
    };

  };

  config = {
    virtualisation.docker.enable = config.services.docker.enable;

    environment.systemPackages = [
      pkgs.docker
      pkgs.docker-compose
    ];

  };
}

