{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.desktop.enable {
    environment.systemPackages = with pkgs; [

      inputs.mip.packages."${ pkgs.system }".default
    ];
  };
}
