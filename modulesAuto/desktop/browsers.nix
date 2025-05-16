{ config, lib, pkgs, ... }:{

  config = lib.mkIf config.nixos.desktop.enable {
    environment.systemPackages = with pkgs; [
      firefox
      librewolf
      ungoogled-chromium
    ];

    #  environment.sessionVariables = {
    #    MOZ_ENABLE_WAYLAND = "1";
    #  };

  };
}
