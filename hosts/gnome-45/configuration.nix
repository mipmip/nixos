{ config, lib, inputs, system, pkgs, unstable, ... }:

{
  imports =
    [
      ../../modules/base-common.nix
      ../../modules/base-git.nix
      ../../modules/base-tmux.nix
      ../../modules/desktop-firefox.nix
      ../../modules/desktop-gnome-45.nix

      ../../modules/nur-my-pkgs.nix
      ../../modules/nix-vm-test.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
       experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    mipmip_pkg.amazon-cloudwatch-agent
  ];

#  systemd.services.amazon-cloudwatch-agent = {
#    enable = true;
#    description = "Amazon CloudWatch Agent";
#    unitConfig = {
#      Type = "simple";
#    };
#    serviceConfig = {
#      ExecStart = "${mipmip_pkg.amazon-cloudwatch-agent}/bin/start-amazon-cloudwatch-agent";
#      Restart = "on-failure";
#      RestartSec = 60;
#      KillMode="process";
#    };
#    wantedBy = [ "multi-user.target" ];
#    after="network.target";
#  };

  virtualisation.vmVariant = {

    virtualisation = {
      memorySize =  4096;
      cores = 3;

      # login this machine with ssh -p2222 pim@localhost
      forwardPorts = [
        {
          from = "host";
          host.port = 2222;
          guest.port = 22;
        }
      ];

    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services.openssh.enable = true;

  boot.plymouth.enable = true;
  boot.plymouth.theme="breeze";
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;

  networking.hostName = "gnome-45";
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
