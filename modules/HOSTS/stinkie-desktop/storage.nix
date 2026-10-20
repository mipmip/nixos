{
...
}:
{
  flake.modules.nixos.stinkie = { ... }: {

    # Second-hand 1 TB Seagate on ata3, LUKS2 over a single GPT partition. The
    # keyfile lives on the already-encrypted root, so the disk unlocks without a
    # prompt and stinkie still boots unattended. systemd-cryptsetup-generator
    # turns this crypttab line into the unlock unit.
    #
    # The keyfile is deliberately NOT in the nix store (anything under
    # environment.etc.<name>.text is world-readable there) and NOT in agenix
    # (/run/agenix is populated during system activation, which is later than
    # the generated unlock unit). It is created out of band:
    #
    #   install -d -m 700 /etc/luks-keys
    #   dd if=/dev/urandom of=/etc/luks-keys/immich-data.key bs=4096 count=1
    #   chmod 400 /etc/luks-keys/immich-data.key
    #   cryptsetup luksAddKey /dev/sdb1 /etc/luks-keys/immich-data.key
    #
    # A reinstall of stinkie therefore has to restore that file before this
    # filesystem appears.
    environment.etc.crypttab.text = ''
      immich-data UUID=785451db-1d29-4f47-b88c-aba7c9526e0a /etc/luks-keys/immich-data.key luks,nofail
    '';

    # nofail so a missing or unopened disk degrades to "no photos" rather than
    # dropping the host into emergency mode where deploy-rs cannot reach it.
    fileSystems."/mnt/immich-data" = {
      device = "/dev/disk/by-uuid/834d2188-7ad4-43a4-8e4e-4113d0132012";
      fsType = "ext4";
      options = [ "nofail" "x-systemd.device-timeout=30s" ];
    };

  };
}
