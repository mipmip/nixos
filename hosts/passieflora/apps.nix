{ config, pkgs, unstable, ...}:
{
  environment.systemPackages = with pkgs; [

    vim
    wget
    tmux
    git

    firefox

    unstable.zoom-us
    unstable.signal-desktop

    unstable.rustdesk

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

    seafile-client
  ];
}
