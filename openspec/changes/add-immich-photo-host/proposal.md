## Why

The photo collection lives as an Aperture export on piethein and has no viewer,
no search and no phone upload path:

```
/volume1/Archief/fotos/aperture-originals    91 GB, 31865 files
```

piethein is a Synology DS414 from 2013: Marvell Armada XP, ARMv7 32-bit, 1 GB
RAM, kernel 3.2.40, DSM 6.2. DSM 7 never shipped for the `armadaxp` platform, so
the box is end of life with no upgrade path. It also negotiates SMB1 only (SMB2
and SMB3 are dropped during negotiation, before authentication), and it already
holds the restic repositories of seven hosts.

Two consequences shape this change:

- Serving a live photo library from piethein would put primary data on the same
  unpatched appliance that holds everyone's backups, collapsing 3-2-1 into
  1-1-1 for the data we least want to lose. Measured TCP latency from stinkie is
  16 ms per connect, which at roughly four round trips per file is about 6
  seconds of pure latency to paint one timeline screen of thumbnails.
- dapperehaan, the original candidate host, is a 2008 Core 2 Duo whose CPU flags
  stop at `sse4_1`: no AVX, no AVX2, not even `sse4_2`. nixpkgs 26.05 has
  removed the pgvecto.rs alternative from the immich module and hardcodes
  `shared_preload_libraries = [ "vchord.so" ]`, with no opt-out. A SIMD-heavy
  vector extension on a pre-AVX CPU is at best a gamble, and the initial
  thumbnail and CLIP pass over 31865 files on two 2.53 GHz cores would run for
  weeks regardless.

stinkie is the right host and already carries the hardware: i5-7400 with AVX2,
31 GB RAM, and a GTX 1050 for CUDA. A second-hand 1 TB disk now gives it 916 GiB
of encrypted local storage, which removes the network from the data path
entirely and returns piethein to the single job it is still good at, holding
encrypted restic repositories.

## What Changes

Part of this has already been applied by hand and is recorded here so the repo
and the running machine agree. The rest is new work.

### Already applied

- `modules/HOSTS/stinkie-desktop/configuration.nix`: `role-desktop-pim` replaced
  by `role-server`; gdm, gnome, xserver, printing, pipewire/rtkit and firefox
  removed; the home configuration dropped `role-pim-desktop` and the wallpaper.
  The NVIDIA driver was kept for immich's machine-learning worker.
- `nix.settings.trusted-users = [ "root" "pim" ]` added, matching
  dapperehaan/durer/hurry/harry. Without it `rme deploy_remote stinkie` fails at
  the copy step with "lacks a signature by a trusted key".
- `modules/HOSTS/stinkie-desktop/storage.nix`: new, carrying the crypttab line
  and the `/mnt/immich-data` mount.
- `modules/HOSTS/stinkie-desktop/deploy.nix`: new, registering stinkie as a
  deploy-rs node at its nebula address.

### Still to do

- Enable `services.immich` with its media location on the encrypted disk, its
  machine-learning worker on, and the GPU passed through for acceleration.
- Seed a first batch of photos from piethein so immich can be exercised within
  minutes instead of after a full 91 GB import.
- Back up the immich database and library, so the photos are not single-copy on
  a drive with 31193 power-on hours.

## Capabilities

### New Capabilities

- `immich-photo-hosting`: stinkie runs immich against the encrypted local disk,
  with the library seeded from piethein and backed up to it.
- `stinkie-server-role`: stinkie is a headless server that cannot suspend, and
  whose boot requires someone at the console.

### Modified Capabilities

- `host-backups`: gains stinkie as a backup client with immich datasets.

## Impact

- `modules/HOSTS/stinkie-desktop/`: `configuration.nix`, `storage.nix`,
  `deploy.nix`, `hardware.nix`, plus a new `immich.nix`.
- `secrets/`: a new age secret for the immich database password, and
  `secrets.nix` gains stinkie as a recipient. No secret enters the store.
- The LUKS keyfile for the photo disk is deliberately outside both the store and
  agenix, and the reasoning is recorded in `storage.nix`.

Constraints:

- **Every boot needs a human.** stinkie's root volume is LUKS with no keyfile
  and no initrd SSH, so it halts at the passphrase prompt and does not reach the
  network until someone types it. Remote unlock is deferred out of this change:
  NixOS initrd networking is wired-only, and stinkie stays on wifi (`wlp3s0`,
  iwlwifi) with `enp4s0` showing no carrier, so it cannot be implemented at all
  for now. Reboots must be planned for when the console is attended.
- `services.immich.mediaLocation` is a single path. Splitting `thumbs/` onto the
  SSD while `library/` sits on the spinning disk would need bind mounts, not an
  option.
- The photo disk is a Seagate ST1000DM003 with 31193 power-on hours. SMART is
  clean (zero reallocated, zero pending, zero CRC errors, no logged errors) but
  this is the Barracuda family with the worst published failure record. It is
  acceptable as the live copy only because piethein keeps the originals and the
  backup task below exists.
