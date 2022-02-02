{ config, pkgs, ... }:

{
  imports = [
    ./vim.nix
    ./zsh.nix
    ./git.nix
    ./fzf.nix
  ];
}

