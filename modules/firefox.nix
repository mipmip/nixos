{ config, ... }:

{

    firefox
  environment.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
    };
}
