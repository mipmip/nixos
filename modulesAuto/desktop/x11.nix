{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.desktop.enable {
    environment.systemPackages = with pkgs; [
      xclip
      xdragon # Drag and drop utility
    ];
  };
}

