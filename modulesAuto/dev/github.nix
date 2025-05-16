{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {
    environment.systemPackages = with pkgs; [
      gh
      actionlint
      act # run github workflows locally
    ];
  };
}

