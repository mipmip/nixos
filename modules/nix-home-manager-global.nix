{ config, pkgs, ...}:

{
  home-manager.useGlobalPkgs = true;

  home-manager.users.root = {
    home.stateVersion = "22.05";
    programs.zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = false;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins=["git" "tmux" "docker" "python" "vi-mode" "systemd" ];
        extraConfig=
          ''
          zstyle :omz:plugins:ssh-agent identities id_rsa id_rsa2 id_github
          '';
      };
    };

    programs.vim = {
      enable = true;
      settings = {
        relativenumber = false;
        number = false;
      };
      plugins = with pkgs.vimPlugins; [
        vim-nix
      ];
    };
  };


}
