{ self, ... }:
{
  # Deployed from peterspav with `rme deploy_remote stinkie`. Targeted over
  # nebula rather than the LAN address: stinkie is on wifi (192.168.2.15) with
  # its ethernet unplugged, so the DHCP lease is the less stable of the two.
  flake.deploy = self.lib.makeDeployNode {
    hostname = "stinkie";
    ip = "192.168.100.17";
    system = "x86_64-linux";
  };
}
