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
    /home/pim/nixos/home-pim/files-main
    /home/pim/nixos/home-pim/files-macos

    /home/pim/nixos/home-pim/programs/fzf.nix
    /home/pim/nixos/home-pim/programs/git.nix
    /home/pim/nixos/home-pim/programs/tmux.nix
    /home/pim/nixos/home-pim/programs/vim.nix
    /home/pim/nixos/home-pim/programs/zsh.nix

    /home/pim/nixos/home-pim/dconf
  ];


}
