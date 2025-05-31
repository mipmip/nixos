{ config, lib, pkgs, unstable, ... }:{

  config = lib.mkIf config.nixos.tex.enable {
    environment.systemPackages = with pkgs; [
      mipmip_pkg.fred # needed for linny
      ruby # for Linny
      sc-im
      unstable.hugo
    ];
  };
}


