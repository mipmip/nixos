{ inputs, self, ... }:

let
  hostname = "stinkie";
in

{

  flake.syncthingDevices.stinkie = "CDLHB62-QND3KF7-MEZ2A4Y-LRTQ7U4-GC4EHT3-42UO34M-ASYR7ZP-33326QP";

  flake.homeConfigurations = {

    # CLI only: stinkie is a server now, so role-pim-desktop (firefox,
    # thunderbird, hyprland, gimp, obs, mipbar, wallpaper) is gone along with
    # the NixOS desktop role.
    "pim@stinkie" = self.lib.makeHomeConf {
      inherit hostname;
      imports = with inputs.self.modules.homeManager; [
        role-pim-cli-full
        role-pim-cli-minimal
      ];
    };
  };

  flake.nixosConfigurations = {

    stinkie = self.lib.makeNixos {
      inherit hostname;
      system = "x86_64-linux";
    };
  };

  flake.modules.nixos.stinkie = { config, pkgs, lib, ... } : {
    system.stateVersion = "26.05";

    # Allow pim to push unsigned store paths (deploy-rs). Matches
    # dapperehaan/durer/hurry/harry. Without it `rme deploy_remote stinkie`
    # fails at the copy step with "lacks a signature by a trusted key".
    nix.settings.trusted-users = [ "root" "pim" ];

    imports = with inputs.self.modules.nixos; [

      system-default
      channel-default

      role-devbox
      role-server
      role-nebula-node

      system-trusted-pim
      secrets-honeybadger
      nix-github-token
      syncthing-work-pool

    ];

    mipnix.syncthing.pool.enable = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # The GTX 1050 driver survives the desktop removal because immich's
    # machine-learning worker wants CUDA. videoDrivers is what gates the whole
    # nvidia module in nixpkgs, not services.xserver.enable, so listing it here
    # with X switched off is the supported headless form.
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      powerManagement.enable = false;
    };

    console.keyMap = "nl";

    boot.initrd.systemd.contents."/etc/vconsole.conf".source =
      lib.mkForce (pkgs.writeText "vconsole.conf" "KEYMAP=us\n");

    users.users."pim" = {
      isNormalUser = true;
      description = "pim";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      vim
      gum
      tmux
      git
      htop
      btop
      claude-code
    ];

    services.openssh.enable = true;

  };

}
