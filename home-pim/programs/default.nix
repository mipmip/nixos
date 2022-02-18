{ config, pkgs, ... }:

{
  imports = [
    ./vim.nix
    ./tmux.nix
    ./zsh.nix
    ./git.nix
    ./fzf.nix
    ./xdg.nix
  ];
}

