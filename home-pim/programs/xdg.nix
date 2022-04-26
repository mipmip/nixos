{ config, pkgs, ... }:
{
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

    vim = {

      name           = "Vim";
      comment        = "Vim";
      genericName    = "Vim";
      exec           = "st -e vim";
      categories     = [
        "TerminalEmulator"
      ];
      terminal       = false;
      startupNotify  = true;
      type           = "Application";
      icon           = "gvim";
      settings       = {
        Keywords = "shell;prompt;command;commandline;cmd;";
        StartupWMClass = "vim";
      };
    };

    quiqr-desktop = {

      name           = "Quiqr Desktop";
      comment        = "Quiqr Desktop";
      genericName    = "quiqr desktop";
      exec           = "st";
      categories     = [ "TerminalEmulator" ];
      terminal       = false;
      startupNotify  = true;
      type           = "Application";
      icon           = "org.quiqr.quiqr-desktop";
      settings       = {
        Keywords = "shell;prompt;command;commandline;cmd;";
        StartupWMClass = "quiqr";
      };
    };
  };
}
