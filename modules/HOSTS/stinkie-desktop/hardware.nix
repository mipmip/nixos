{
lib,
inputs,
...
}:
{
  flake.modules.nixos.stinkie = { config, pkgs, lib, ... }: {

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usbhid" "usb_storage" "ums_realtek" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    boot.initrd.luks.devices."cryptroot" = {
      device = "/dev/disk/by-partuuid/d31257f4-05ce-466d-8ebd-1abbd849bc57";
      allowDiscards = true;
    };

    fileSystems."/" =
      { device = "/dev/disk/by-uuid/5d7fed3f-24dc-4c36-93fe-9e99d410faa2";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/4F88-BAA4";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/9e7e4d32-ad0d-4b9a-9394-06709ee3368b"; }
      ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.enableRedistributableFirmware = true;
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
