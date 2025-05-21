{ lib, ... } : {

  options.nixos.trusted.enable = lib.mkEnableOption "enable we trust the root user";

}
