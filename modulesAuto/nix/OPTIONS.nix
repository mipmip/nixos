{ lib, ... } : {

  options.nixos.nixUtils.enable = lib.mkEnableOption "enable nix tools";
  options.nixos.nixRemoteBuilds.enable = lib.mkEnableOption "enable nix tools";

}
