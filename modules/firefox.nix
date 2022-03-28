{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    unstable.firefox
    texlive.combined.scheme-full
  ];
}




{ config, ... }:

{

  environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
}
