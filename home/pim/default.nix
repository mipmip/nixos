{ home, config, lib, ... }:
let
  cfg = config.homeConf;
in

{

  options.homeConf.isDesktop = lib.mkEnableOption "Setup desktop environment";
  options.homeConf.withLinny = lib.mkEnableOption "Make linny secondbrain available on this computer";
  options.homeConf.withAws = lib.mkEnableOption "Setup AWS config";
  options.homeConf.username = lib.mkOption {
    type = lib.types.str;
    description = ''
      posix uername
    '';
    example = ''
      pim
    '';
  };
  options.homeConf.homedir = lib.mkOption {
    type = lib.types.str;
    description = ''
      home directory
    '';
    example = ''
      /home/pim
    '';
  };
  options.homeConf.tmuxPrefix = lib.mkOption {
    type = lib.types.str;
    description = ''
      Tmux Prefix key
    '';
    example = ''
      a
    '';
  };

  config =
    let
      desktopImports = lib.mkIf cfg.isDesktop [./_roles/home-base-nixos-desktop.nix];
    in


    lib.mkIf cfg.withLinny {
        services.secondbrain.enable = true;
    } //

    lib.mkIf cfg.withAws {
      dotfiles.awsstuff.enable = true;
    } //

    {
      home.stateVersion = "22.05";
      home.username = cfg.username;
      home.homeDirectory = cfg.homeDirectory;

      imports = [
        ./_hm-modules
        ./_roles/home-base-all.nix
        desktopImports
        ./conf-cli/smug_and_skull.nix
      ];
    };

}
