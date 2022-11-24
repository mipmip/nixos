{ config, pkgs, ... }:

{
  programs.zsh = {
    shellAliases = {
      python = "/usr/bin/python3";
    };

  };
}
