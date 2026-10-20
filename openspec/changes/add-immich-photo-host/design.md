## Context

Three candidate hosts and two transports were considered before landing here.
The measurements that decided it are recorded so the reasoning survives.

### Why not piethein itself

```
platform   synology_armadaxp_ds414    Marvell Armada XP, ARMv7 32-bit
RAM        1 GB
kernel     Linux 3.2.40 #25556
DSM        6.2, end of life
```

32-bit ARMv7 with 1 GB of RAM, and DSM 6.2 on an ARM model never had the
Docker/Container Manager package. immich does not ship for this platform and the
box could not run it if it did.

### Why not dapperehaan

```
CPU     Intel Core 2 Duo P8700, 2 cores @ 2.53 GHz (2008)
flags   ssse3 sse4_1          no sse4_2, no avx, no avx2
RAM     7 GB
```

nixpkgs 26.05 hardcodes VectorChord in the immich module and has removed the
pgvecto.rs alternative, so a SIMD-heavy vector extension is mandatory. Even if
it loaded, the first scan over 31865 files on two Penryn cores is a multi-week
job.

### Why stinkie

```
CPU     Intel i5-7400, 4 cores @ 3.0 GHz      sse4_2 avx avx2
RAM     31 GB
GPU     GTX 1050, 2 GB, driver 580            CUDA + NVENC
disk    916 GiB LUKS2 ext4 on a 1 TB SATA drive
```

### Why local storage rather than NFS or SMB

piethein negotiates SMB1 only. SMB2 and SMB3 are refused during negotiation,
before authentication:

```
NT1   handshake OK, anonymous logon rejected
SMB2  connection dropped during negotiation
SMB3  connection dropped during negotiation
```

SMB1 has no session encryption, uses NTLMv1-era authentication, and is lockstep
for most operations. NFS was the better of the two and is already running on the
NAS, but both lose to a local disk once one exists:

| | NFS to piethein | local disk |
| --------------------- | ----------------- | ---------- |
| latency per file      | ~16 ms            | microseconds |
| POSIX semantics       | squash/uid mapping | native ext4 |
| atomic upload→library | cross-mount caveats | just works |
| piethein's role       | primary + backup  | backup only |

The 91 GB library against 916 GiB available settles it: the disk is roughly ten
times larger than needed, so there is no reason to reach across the wire.

## Goals / Non-Goals

**Goals**

- immich serving the full library from encrypted local storage on stinkie.
- stinkie stays up once booted: no suspend, no desktop, no idle sleep.
- A seeded first batch so immich is testable in minutes, not hours.
- The photos are not single-copy on a second-hand drive.

**Non-Goals**

- Unattended booting. The root volume stays LUKS with no keyfile, so a human
  types the passphrase at every boot. Remote unlock is deferred, not pursued.
- Replacing piethein. It stays as the restic target.
- Exposing immich to the public internet.
- Migrating any other host off its desktop role.
- Importing from any source other than `aperture-originals` in this change.

## Decisions

### Remote unlock is deferred, and why

Not part of this change. stinkie stays on wifi, and NixOS initrd networking has
no wpa_supplicant, so `boot.initrd.network.ssh` cannot be made to work at all
until `enp4s0` has a carrier. The consequence is that every boot halts at the
passphrase prompt until someone is at the keyboard, which the spec records as an
operational constraint of the host.

The rest of this section is kept so the work is ready if a cable is ever run.

#### Remote unlock authenticates the machine, not the user

`boot.initrd.network.ssh` needs a host key, and that key has to be readable
before the root volume is open, so it lives on the unencrypted `/boot`
partition. Anyone who takes the disk out can read it. That is acceptable because
the key proves the initrd's identity to a connecting admin; it grants no access
to anything. The passphrase still has to be typed over that connection, so the
secret that protects the data never rests on `/boot`.

The authorized key is pim's existing SSH public key, the same one already
trusted by the mesh.

#### The initrd needs a network driver

`boot.initrd.availableKernelModules` currently holds only storage and USB
modules. `r8169` has to be added or the initrd comes up with no interface, and
`boot.initrd.network.ssh` has nothing to listen on.

#### Wired only, by necessity

NixOS initrd networking has no wpa_supplicant. stinkie is on wifi today with
`enp4s0` down. The remote-unlock work is therefore gated on plugging in a cable,
and the cable is worth having regardless: the 16 ms we measured to piethein is
mostly stinkie's wifi link.

### One media location, on the encrypted disk

`services.immich.mediaLocation` takes a single path. Putting `thumbs/` on the
SSD and `library/` on the spinning disk would require bind mounts under that one
path, and would split a tree immich expects to rename within atomically. With 62
GB free on the SSD and 916 GiB on the data disk, the gain does not justify it.
Everything goes to the encrypted disk; postgres stays on the SSD under
`/var/lib`, which is where it must be in any case.

### The database password is an age secret

`services.immich` provisions its own postgres locally, but the dump task below
needs a credential and the repo's convention is that credentials are paths into
agenix, never literals in a Nix option.

## Risks / Trade-offs

- **The drive.** 31193 power-on hours on an ST1000DM003. SMART is clean today,
  with zero reallocated sectors, zero pending, zero CRC errors and no logged
  errors, but the family's record is poor. Mitigated by piethein keeping the
  originals and by backing the library up; not mitigated by the SMART result,
  which says nothing about tomorrow.
- **GPU memory.** 2 GB of VRAM is enough for CLIP ViT-B/32 and the face
  detection model, but it is tight. If the ML worker runs out, it falls back to
  CPU and the import gets slower rather than failing.
- **The LUKS keyfile is not declarative.** It cannot go in the store, because
  anything under `environment.etc.<name>.text` is world-readable there, and it
  cannot come from agenix, because `/run/agenix` is populated during system
  activation, later than the generated unlock unit. A stinkie reinstall must
  restore it by hand or the photo disk will not mount. The recreate commands are
  in `storage.nix`.
- **Deleting the desktop is not trivially reversible** in the sense that getting
  it back means another full rebuild and roughly 32 GiB of closure.

## Resolved Questions

### The library is external and read-only

immich indexes `aperture-originals` in place and never writes to it. The
`2000`..`2015` year folders survive as they are, deleting in immich does not
delete a file, and the copy on stinkie stays byte-comparable with the source on
piethein. Phone uploads go to immich's own managed area, which is a separate
tree under the same media location.

### The first batch is the year 2000

Roughly 2000 files. Chosen for the fastest possible round trip to a working
screen.

The trade-off is recorded deliberately: 2000 is scans and early compact-camera
JPEGs, so it is the least representative year in the library. Any extrapolation
from its import time to the full 31865 files SHALL be reported as optimistic
rather than as a straight multiple, because later years carry larger files and
more faces per frame.

### Reached over the LAN and the mesh, plain HTTP

No reverse proxy and no certificate. immich answers on its own port to the LAN
and to nebula nodes, which covers the Fairphone once it joins the mesh. Not
exposed publicly, which is already a non-goal.

### The backup covers everything

Both the database and the full library, rather than the database alone. This
duplicates the 91 GB that already sits on piethein as plain files, since a
restic repository on the same NAS is a separate copy rather than a reference to
them. It is affordable: `/volume1` has 1.5 TB free. The gain is one rule with no
reasoning about which files happen to be safe already, and no risk of a
phone-uploaded photo falling through the gap.
