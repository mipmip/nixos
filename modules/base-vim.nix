{ config, lib, pkgs, pkgs-2211, unstable, ... }:

{
  environment.sessionVariables = {
    EDITOR = "vim";
  };

  environment.systemPackages = with pkgs; [

    ctags
    pkgs-2211.sc-im

    git-sync
    gitFull

    unstable.neovim

    #language servers
    sqls
    gopls
    #rnix-lsp
    unstable.nixd
    terraform-ls
    sumneko-lua-language-server

    tree-sitter

    rust-analyzer
    cargo
    rustc
    nodejs

    sox

    # Language Server Dependencies
    nodePackages.pyright
    nodePackages.tailwindcss

    # Formatters
    nixfmt-classic
    rustfmt
    nodePackages.prettier

    ruby # for Linny
  ];
}
