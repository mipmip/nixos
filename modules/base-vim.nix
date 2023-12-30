{ config, lib, pkgs, unstable, ... }:

{
  environment.sessionVariables = {
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [
    ctags
    sc-im
    git-sync
    gitFull
    unstable.neovim

    sqls
    gopls
    rnix-lsp
    rust-analyzer
    sumneko-lua-language-server

    # Language Server Dependencies
    nodePackages.pyright
    nodePackages.tailwindcss

    # Formatters
    nixfmt
    rustfmt
    nodePackages.prettier

    ruby # for Linny
  ];
}
