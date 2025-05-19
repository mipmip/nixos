{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {
    environment.systemPackages = with pkgs; [
      nickel
      yamllint
      sq # Swiss army knife for data
      jq
      yj
      dasel
      jsonnet
    ];
  };
}
