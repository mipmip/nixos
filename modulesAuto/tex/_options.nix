{ lib, ... } : {

  options.nixos.tex.enable = lib.mkEnableOption "enable development tools";

}
