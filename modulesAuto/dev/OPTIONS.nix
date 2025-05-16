{ lib, ... } : {

  options.nixos.dev.enable = lib.mkEnableOption "enable development tools";

}
