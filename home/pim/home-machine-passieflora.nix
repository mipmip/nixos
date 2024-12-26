{ lib, config, pkgs, ... }:

{
  imports = [
    ./_hm-modules
    ./_roles/home-base-all.nix
    ./_roles/home-base-nixos-desktop.nix

    ./conf-cli/smug_and_skull.nix
  ];

  dotfiles.awsstuff.enable = false;
  services.secondbrain.enable = true;
}
