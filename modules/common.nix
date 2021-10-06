{ config, lib, pkgs, ... }:

{

  time.timeZone = "Europe/Amsterdam";
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;
  services.cron.enable = true;

  users.defaultUserShell = pkgs.zsh;
  environment.variables = {
    EDITOR = "vim";
  };

  home-manager.useGlobalPkgs = true;

  users.users.pim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  home-manager.users.root = {
    programs.zsh = {
      enable = true;
      autocd = true;
      enableAutosuggestions = true;

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins=["git" "tmux" "docker" "python" "vi-mode" "systemd" ];
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

  users.users.guest = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
  };

}
