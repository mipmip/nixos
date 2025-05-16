{ lib, ... }:

{
  options.nixos.ai = {
    enable = lib.mkEnableOption "Enable ai";
  };

  options.nixos.aiLocal = {
    enable = lib.mkEnableOption "Enable localAi";
  };
}

