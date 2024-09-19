{

  home.file = {
    ".config/bmc" = {
      source = ./bmc;
      recursive = true;
    };
  };

  home.file = {
    ".ohmyzsh-pim" = {
      source = ./.ohmyzsh-pim;
      recursive = true;
    };
  };

  home.file = {
    ".pandoc" = {
      source = ./.pandoc;
      recursive = true;
    };
  };
  home.file = {
    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

  home.file = {
    ".config/sc-im" = {
      source = ./sc-im;
      recursive = true;
    };
  };

  home.file = {
    ".tmux" = {
      source = ./tmux;
      recursive = true;
    };
  };

  home.file = {
    ".vim" = {
      source = ./vim;
      recursive = true;
    };
  };

  home.file = {
    ".config/smug" = {
      source = ./smug;
      recursive = true;
    };
  };

# NOTE archived
#  home.file = {
#    ".config/wtf" = {
#      source = ./wtf;
#      recursive = true;
#    };
#  };

  home.file = {
    "./.ansible.cfg" = {
      source = ./.ansible.cfg;
    };
  };

  home.file = {
    "./.dirtygit.yml" = {
      source = ./.dirtygit.yml;
    };
  };


#  home.file = {
#    "./.config/alacritty.yml" = {
#      source = ./alacritty.yml;
#    };
#  };

  home.file = {
    ".config/skulls.yaml" = {
      source = ./skulls.yaml;
    };
  };

}
