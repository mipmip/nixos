# THIS FILE IS INTENDED AS SINGLE USER in .config/nixpkgs/home.nix
# after installing home-manager create a symlink ln -s ~/nixos/home/home.nix ~/.config/nixpkgs/
# it's because of the dconf bug

{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pim";
  home.homeDirectory = "/home/pim";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  imports = [
    /home/pim/nixos/home/files
    /home/pim/nixos/home/dconf
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = false;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins=["git" "tmux" "docker" "docker-compose"];
    };
  };


  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ ultisnips ];
    settings = {
      ignorecase = true;
    };

    extraConfig = ''

        if has('python2')
        endif
        if has('python3')
        endif

        for f in split(glob('~/.vim/base*.vim'), '\n')
          exe 'source' f
        endfor

        if has('gui_running')
          for f in split(glob('~/.vim/gui*.vim'), '\n')
            exe 'source' f
          endfor
        else
          for f in split(glob('~/.vim/cli*.vim'), '\n')
            exe 'source' f
          endfor
        endif

        for f in split(glob('~/.vim/last*.vim'), '\n')
          exe 'source' f
        endfor

    '';
  };

  programs.git = {
    enable = true;
    userName = "Pim Snel";
    userEmail = "post@pimsnel.com";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
