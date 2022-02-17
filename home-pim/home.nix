# THIS FILE IS INTENDED AS SINGLE USER in .config/nixpkgs/home.nix
# after installing home-manager create a symlink ln -s ~/nixos/home-pim/home.nix ~/.config/nixpkgs/
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
    /home/pim/nixos/home-pim/files
    /home/pim/nixos/home-pim/dconf
    /home/pim/nixos/home-pim/programs
  ];

  xdg.desktopEntries = {
    st = {

      name           = "st";
      comment        = "st suckless terminal";
      genericName    = "st terminal";
      exec           = "st";
      categories     = [
        "TerminalEmulator"
      ];
      terminal       = false;
      startupNotify  = true;
      type           = "Application";
      icon           = "org.gnome.Terminal";
      settings       = {
        Keywords = "shell;prompt;command;commandline;cmd;";
        StartupWMClass = "st-256color";
      };
    };
  };

}
