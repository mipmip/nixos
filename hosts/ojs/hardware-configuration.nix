# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.kernelPackages = pkgs.linuxPackages;

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];

#  boot.extraModulePackages = [ (config.boot.kernelPackages.broadcom_sta.overrideAttrs (old: {
#    patches = old.patches ++ [
#      (builtins.fetchurl {
#        url = "https://raw.githubusercontent.com/archlinux/svntogit-community/5ec5b248976f84fcd7e3d7fae49ee91289912d12/trunk/012-linux517.patch";
#        sha256 = "df557afdb0934ed2de6ab967a350d777cbb7b53bf0b1bdaaa7f77a53102f30ac";
#      })
#    ];
#  })) ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/203ca9ad-733b-434b-bd6a-f9fd833ff591";
      fsType = "btrfs";
      options = [ "subvol=nixos" "compress=lzo" "autodefrag" "noatime" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/242C-46A0";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/2e14da16-1eb5-4a43-9f1b-feffa2e3d9ad"; }
    ];

}
