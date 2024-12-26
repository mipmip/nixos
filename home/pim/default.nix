{ ... }:

{

  imports = [
    ./_hm-modules

    ./files-main
    ./files-linux

    ./conf-cli/fzf.nix
    ./conf-cli/nnn.nix
    ./conf-cli/git.nix
    ./conf-cli/tmux.nix
    ./conf-cli/vim.nix
    ./conf-cli/atuin.nix
    ./conf-cli/neovim.nix
    ./conf-cli/zsh.nix
    #./conf-cli/awscli.nix
    #./conf-cli/smug_and_skull.nix

    # ./_roles/home-base-all.nix
    #  ./_roles/home-base-nixos-desktop.nix

    #./files-gimp

    ./conf-cli/alacritty.nix
    #./conf-cli/terminals.nix

    #./conf-desktop-linux/firefox.nix
    #./conf-desktop-linux/obs.nix
    #./conf-desktop-linux/xdg.nix

    #./conf-gnome

    ];

  }
