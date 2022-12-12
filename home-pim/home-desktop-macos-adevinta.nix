{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.username = "pim.snel";
  home.homeDirectory = "/Users/pim.snel";
  home.stateVersion = "22.05";

  imports = [
    /Users/pim.snel/nixos/home-pim/files-main
    /Users/pim.snel/nixos/home-pim/files-macos
    /Users/pim.snel/nixos/home-pim/files-secondbrain
    /Users/pim.snel/nixos/home-pim/files-i-am-desktop
    /Users/pim.snel/nixos/home-pim/programs/fzf.nix
    /Users/pim.snel/nixos/home-pim/programs/git.nix
    /Users/pim.snel/nixos/home-pim/programs/tmux.nix
    /Users/pim.snel/nixos/home-pim/programs/macos-bundle.nix
    /Users/pim.snel/nixos/home-pim/programs/vim.nix
    /Users/pim.snel/nixos/home-pim/programs/zsh.nix
    #/Users/pim.snel/nixos/home-pim/programs/zsh_macos_extra.nix
  ];


}
