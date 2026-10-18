{ inputs, self, ... }:

let
  hostname = "stinkie";
in

{

  flake.syncthingDevices.stinkie = "CDLHB62-QND3KF7-MEZ2A4Y-LRTQ7U4-GC4EHT3-42UO34M-ASYR7ZP-33326QP";

  flake.homeConfigurations = {

    "pim@stinkie" = self.lib.makeHomeConf {
      inherit hostname;
      imports = (with inputs.self.modules.homeManager; [
        role-pim-cli-full
        role-pim-cli-minimal
        role-pim-desktop
      ]) ++ [
        { mip.hostWallpaper.enable = true; }
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

    imports = with inputs.self.modules.nixos; [

      system-default
      channel-default

      role-devbox
      role-desktop-pim
      role-nebula-node

      system-trusted-pim
      secrets-honeybadger
      nix-github-token
      syncthing-work-pool

    ];

    mipnix.syncthing.pool.enable = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    services.xserver.enable = true;
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    hardware.graphics.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      powerManagement.enable = true;
    };

    console.keyMap = "nl";

    boot.initrd.systemd.contents."/etc/vconsole.conf".source =
      lib.mkForce (pkgs.writeText "vconsole.conf" "KEYMAP=us\n");

    services.printing.enable = true;

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users."pim" = {
      isNormalUser = true;
      description = "pim";
      extraGroups = [ "networkmanager" "wheel" ];
    };

    programs.firefox.enable = true;

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
