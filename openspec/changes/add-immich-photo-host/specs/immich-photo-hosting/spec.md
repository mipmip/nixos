# immich-photo-hosting Specification

## ADDED Requirements

### Requirement: The photo library lives on encrypted local storage
The media location SHALL be a directory on stinkie's LUKS-encrypted data disk,
never a network share.

The disk SHALL unlock without interaction, from a keyfile held on the already
encrypted root, and SHALL be mounted with `nofail` so a missing disk degrades to
"no photos" rather than dropping the host into emergency mode where deploy-rs
cannot reach it.

#### Scenario: The disk mounts itself at boot
- **WHEN** stinkie finishes booting
- **THEN** `/mnt/immich-data` SHALL be mounted from `/dev/mapper/immich-data`
- **AND** no passphrase SHALL have been requested for it

#### Scenario: Media never crosses the network
- **WHEN** `services.immich.mediaLocation` is inspected
- **THEN** it SHALL resolve to a path under `/mnt/immich-data`
- **AND** no NFS or CIFS mount SHALL appear in the path's resolution

### Requirement: The machine-learning worker uses the GPU
immich's machine-learning service SHALL be enabled and SHALL be given access to
the NVIDIA device nodes, so the initial CLIP and face-detection pass over 31865
files completes in hours rather than days.

#### Scenario: The GPU is passed through
- **WHEN** `services.immich.accelerationDevices` is inspected
- **THEN** it SHALL list the NVIDIA device nodes rather than being `null`

#### Scenario: Falling back is acceptable
- **WHEN** the 2 GB of VRAM is insufficient for a model
- **THEN** the worker SHALL fall back to CPU
- **AND** this SHALL be treated as slower, not as a failure

### Requirement: A first batch is seeded before the full import
The year `2000` of `aperture-originals` SHALL be copied from piethein to stinkie
before the remaining 91 GB, so immich can be exercised within minutes of coming
up.

The copy SHALL use rsync over SSH rather than a mount, because the NAS
negotiates SMB1 only and its NFS exports are scoped to a subnet that no longer
exists.

#### Scenario: The batch arrives
- **WHEN** the seed step completes
- **THEN** `2000` SHALL exist under the external library path
- **AND** its file count and byte size SHALL be reported

#### Scenario: Extrapolation is qualified
- **WHEN** the batch import time is used to estimate the full import
- **THEN** the estimate SHALL be reported as optimistic rather than as a
  straight multiple, because `2000` holds scans and early compact-camera files
  and is the least representative year in the library

#### Scenario: The source is untouched
- **WHEN** the copy runs
- **THEN** rsync SHALL be invoked without `--delete`
- **AND** `/volume1/Archief/fotos/aperture-originals` on piethein SHALL be
  byte-identical afterwards

### Requirement: The originals are indexed in place, never rewritten
immich SHALL treat the copied `aperture-originals` tree as a read-only external
library rather than importing it into its own managed storage.

The `2000`..`2015` year folders SHALL survive unchanged, so the copy on stinkie
stays byte-comparable with the source on piethein.

#### Scenario: The structure survives
- **WHEN** the external library path is listed after indexing
- **THEN** it SHALL still contain the year folders as they arrived
- **AND** no file SHALL have been renamed by a storage template

#### Scenario: Deleting in immich
- **WHEN** an asset from the external library is deleted in the immich UI
- **THEN** the underlying file SHALL remain on disk

#### Scenario: Phone uploads are separate
- **WHEN** a photo is uploaded from a phone
- **THEN** it SHALL land in immich's own managed tree
- **AND** SHALL NOT be written into the external library path

### Requirement: The library is not single-copy
The immich database and the full media tree SHALL be backed up, because the data
disk is a second-hand drive with 31193 power-on hours from the Barracuda family
with the worst published failure record.

The database SHALL be dumped before the snapshot rather than copied live, using
the `prepareCommand` hook the backup role already provides.

The full library is backed up even though piethein already holds the originals
as plain files. A restic repository on the same NAS is a separate copy rather
than a reference to them, so this duplicates roughly 91 GB. That is deliberate:
it gives one rule with no reasoning about which files happen to be safe already,
and no gap for a phone-uploaded photo to fall through.

#### Scenario: The database is captured consistently
- **WHEN** the backup runs
- **THEN** a `pg_dump` SHALL have produced a dump file before restic reads it
- **AND** the dump SHALL be removed afterwards by `cleanupCommand`

#### Scenario: The media is covered
- **WHEN** the dataset paths are inspected
- **THEN** they SHALL include the external library and immich's managed tree

#### Scenario: piethein holds the source copy
- **WHEN** the originals are considered
- **THEN** `/volume1/Archief/fotos/aperture-originals` SHALL remain on piethein
  as the untouched source
- **AND** deleting it SHALL be out of scope for this change

### Requirement: immich is not reachable from the public internet
The service SHALL be bound such that it is reachable only from the LAN and the
nebula mesh.

#### Scenario: No public exposure
- **WHEN** the host's listening sockets are inspected
- **THEN** immich SHALL NOT be reachable from outside the LAN or the mesh
- **AND** no port forward SHALL be created for it
