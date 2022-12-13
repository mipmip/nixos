{ config, pkgs, ... }:

{
  programs.zsh = {

    shellAliases = {
      python = "/usr/bin/python3";
    };

    initExtra = ''
# Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
# End Nix
    '';

  };
}
