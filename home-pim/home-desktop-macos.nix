# THIS FILE IS INTENDED AS SINGLE USER in .config/nixpkgs/home.nix
# after installing home-manager create a symlink ln -s ~/nixos/home-pim/home.nix ~/.config/nixpkgs/
# it's because of the dconf bug

{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "pim";
  home.homeDirectory = "/Users/pim";
  home.stateVersion = "22.05";

  imports = [
    /Users/pim/nixos/home-pim/files-main
    /Users/pim/nixos/home-pim/files-macos
    /Users/pim/nixos/home-pim/programs/fzf.nix
    /Users/pim/nixos/home-pim/programs/git.nix
    /Users/pim/nixos/home-pim/programs/tmux.nix
    /Users/pim/nixos/home-pim/programs/vim.nix
    /Users/pim/nixos/home-pim/programs/zsh.nix
    /Users/pim/nixos/home-pim/dconf
  ];


}
