{ config, pkgs, unstable, ...}:
{
  environment.systemPackages = with pkgs; [

    vim
    wget
    tmux
    git

    unstable.firefox
    unstable.bitwarden
    unstable.google-chrome

#    unstable.cups-brother-hl1210w
    unstable.zoom-us
    unstable.signal-desktop
    unstable.flare-signal

    thunderbird

    rustdesk

    home-manager

    gcc
    pkg-config
    telegram-desktop
    gnumake

    gimp
    inkscape

    libreoffice
    hunspellDicts.nl_nl

    kitty
    unstable.ghostty
    alacritty

    gnome-tweaks
    gdm-settings
    gpaste

    jdk
    seafile-client
  ];
  

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        cups-brother-hl1210w
      ];
    };
  };

}

