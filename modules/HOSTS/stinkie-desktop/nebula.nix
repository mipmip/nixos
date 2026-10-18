{ ... }:
{
  flake.modules.nixos.stinkie = { config, ... }: {

    age.secrets = {
      "nebula-stinkie-cert" = {
        file = ../../../secrets/nebula-stinkie.crt.age;
        path = "/var/lib/nebula/nebula-stinkie.crt";
        owner = "nebula-mesh";
        group = "root";
        mode = "600";
      };
      "nebula-stinkie-key" = {
        file = ../../../secrets/nebula-stinkie.key.age;
        path = "/var/lib/nebula/nebula-stinkie.key";
        owner = "nebula-mesh";
        group = "root";
        mode = "600";
      };
    };

    services.nebula.networks.mesh = {
      cert = config.age.secrets."nebula-stinkie-cert".path;
      key = config.age.secrets."nebula-stinkie-key".path;
    };
  };
}
