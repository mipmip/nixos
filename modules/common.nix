{ config, lib, pkgs, ... }:

{

  #setxkbmap -option caps:none

  time.timeZone = "Europe/Amsterdam";

  nixpkgs.config = {

    allowUnfree = true;

    packageOverrides = super: let self = super.pkgs; in {

      mumble = super.mumble.override { pulseSupport = true; };

      linuxPackages = super.linuxPackages // {
        e1000e = super.linuxPackages.e1000e.overrideDerivation (old: {
          name = "e1000e-3.3.3-${config.boot.kernelPackages.kernel.version}";
          src = fetchurl {
            url = "https://www.dropbox.com/s/pxx883hx9763ygn/e1000e-3.3.3.tar.gz?dl=0";
            sha256 = "1s2w54927fsxg0f037h31g3qkajgn5jd0x3yi1chxsyckrcr0x80";
          };
        });
      };
    };
  }

  services.openssh.enable = true;
  services.cron.enable = true;

  users.defaultUserShell = pkgs.zsh;

  services.lorri.enable = true;

  users.users.pim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "disk"];
  };

  users.users.tim = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager" "disk"];
  };

  users.users.guest = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
  };

}
