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
    unstable.nixd
    tree-sitter
    rust-analyzer
    cargo
    rustc
    sumneko-lua-language-server

    sox


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
