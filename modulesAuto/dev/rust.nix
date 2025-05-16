{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {
    environment.systemPackages = with pkgs; [
      rust-analyzer
      cargo
      rustc
      rustfmt
    ];
  };
}

