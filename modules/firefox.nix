{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
  ];
}




{ config, ... }:

{

    firefox
  environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
}
