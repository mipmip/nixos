{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.dev.enable {

    programs.adb.enable = true;

    users.users.pim.extraGroups = ["adbusers"];

    environment.systemPackages = with pkgs; [
      android-tools
    ];
  };
}

