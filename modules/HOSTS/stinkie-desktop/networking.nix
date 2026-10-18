{
...
}:
let
  hostname = "stinkie";
in
{
  flake.nebulaNodes.stinkie = "192.168.100.17";

  flake.modules.nixos.stinkie = { config, pkgs, ... } : {

    networking.hostName = hostname;
    networking.firewall.enable = false;
    networking.networkmanager.enable = true;

  };
}
