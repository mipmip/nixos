{ config, lib, pkgs, ... }:

{
  environment.sessionVariables = {
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [
    wget
    gitFull
  ];
}
