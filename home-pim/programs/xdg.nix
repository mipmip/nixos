{ config, pkgs, ... }:
{

#  xdg.mimeApps.enable = false;

  #xdg.mimeApps.associations.added = {
    #"application/x-yaml" = [ "xvim.desktop"];
#  };

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

    gvim = {

      name           = "gvim";
      comment        = "gvim";
      genericName    = "gvim";
      exec           = "gvim --remote-tab-silent %F";
      categories     = [
        "Utility"
        "TextEditor"
      ];
      terminal       = false;
      startupNotify  = true;
      type           = "Application";
      icon           = "gvim";
      settings       = {
        Keywords = "Text;editor;";
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
