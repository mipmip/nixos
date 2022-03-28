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


    firefox = {

      name           = "firefox";
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

  };
}
