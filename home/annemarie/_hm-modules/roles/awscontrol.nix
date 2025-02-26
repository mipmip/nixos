{ config, lib, pkgs, unstable, inputs, system, ... }:

{

  options.roles.awscontrol = {
     enable = lib.mkEnableOption "enable aws conf stuff";
  };

  config =
    let

  cfg = config.roles.awscontrol;
    in

   lib.mkIf cfg.enable {

     home.packages = [
        inputs.jsonify-aws-dotfiles.packages."${system}".jsonify-aws-dotfiles
        inputs.bmc.packages."${system}".bmc
        inputs.race.packages."${system}".race
        pkgs.granted
        pkgs.gum
     ];
  };
}
