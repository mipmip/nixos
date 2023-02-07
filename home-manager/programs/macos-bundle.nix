{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.awscli
    pkgs.git
    pkgs.htop
    pkgs.hugo
    pkgs.jq
    pkgs.tldr
    pkgs.tfswitch
    pkgs.yarn
    pkgs.yq
    pkgs.smug
    pkgs.unixtools.watch
    pkgs.git-sync
    pkgs.silver-searcher
    pkgs.fzf
    pkgs.apg
    pkgs.smug
    pkgs.ctags
    pkgs.tmux
  ];
}
