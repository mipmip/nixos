{makeBanner, pkgs, inputs, ...}:
let
  system = pkgs.stdenv.hostPlatform.system;

  # The same two store paths and the same host list the `prefix + M` popup
  # uses, so the window and the popup cannot report on different hosts. Both
  # were `nix run github:mipmip/...` here, which cost a flake resolution every
  # time the session opened and made the monitor depend on the network being
  # up to say whether the network was up.
  nbping = "${inputs.nping.packages.${system}.default}/bin/nbping";
  updo = "${inputs.updo.packages.${system}.updo}/bin/updo";
  nebulaHosts = builtins.concatStringsSep " " inputs.self.lib.nebulaHostNames;
in
{

  sudo = {
    windows = [{
      name = "root";
      layout = "main-vertical";
      commands = [ (makeBanner "root") "sudo su -" ];
    }];
  };

  nixos = {
    root = "~/mipnix";
    windows = [
      {
        name = "mipnix";
        layout = "main-vertical";
        commands = [ (makeBanner "nixos") ];
      }
      {
        name = "secrets";
        root = "~/mipnix/secrets";
        layout = "main-vertical";
        commands = [ (makeBanner "nixos secrets") ];
      }
      {
        name = "mipnix";
        root = "~/mipnix";
        layout = "main-vertical";
        commands = [ (makeBanner "mipnix") ];
      }
    ];
  };

  monitoring = {
    root = "~/cMonitoring";
    windows = [

      {
        name = "CoreVitals";
        layout = "tiled";
        commands = [
          "${pkgs.btop}/bin/btop"
        ];

        panes = [
          {
            type = "horizontal";
            commands = [ "${pkgs.claude-monitor}/bin/claude-monitor --plan max5" ];
          }
          {
            type = "horizontal";
            commands = [ "${nbping} -v table -i 3 ${nebulaHosts}" ];
          }
          {
            type = "horizontal";
            commands = [ "${updo} -C ~/.config/updo/config.toml" ];
          }
        ];
      }

    ];
  };

  quiqr-dev-run = {
    root = "~/cQuiqr";
    windows = [

      {
        root = "~/cQuiqr/quiqr-desktop-mipmip";
        name = "Quiqr Mipmip";
        layout = "main-vertical";
        commands = [
          (makeBanner "quiqr mipmip")
          "nix develop -c $SHELL"
        ];
      }

      {
        root = "~/cQuiqr/quiqr-desktop-upstream";
        layout = "main-vertical";
        name = "Quiqr Upstream";
        commands = [
          (makeBanner "quiqr upstream")
          "nix develop -c $SHELL"
        ];
      }
    ];
  };

  doen = {
    root = "~/secondbrain";
    windows = [
      {
        name = "doen";
        layout = "main-horizontal";
        commands = [ "nlin" ];
      }
      {
        name = "sync";
        layout = "main-horizontal";
        commands = [ "watch -n 10 git-sync -n" ];
      }
    ];
  };
}
