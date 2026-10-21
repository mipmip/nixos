# Tasks

## 1. Already applied by hand, recorded here so repo and machine agree

- [x] 1.1 Replace `role-desktop-pim` with `role-server` in
      `modules/HOSTS/stinkie-desktop/configuration.nix`
- [x] 1.2 Remove gdm, gnome, xserver, printing, pipewire/rtkit and firefox from
      the same file
- [x] 1.3 Drop `role-pim-desktop` and `mip.hostWallpaper` from the
      `pim@stinkie` home configuration
- [x] 1.4 Keep the NVIDIA driver via `services.xserver.videoDrivers` with X off
- [x] 1.5 Add `nix.settings.trusted-users = [ "root" "pim" ]`
- [x] 1.6 Create `modules/HOSTS/stinkie-desktop/storage.nix` with the crypttab
      line and the `/mnt/immich-data` mount
- [x] 1.7 Create `modules/HOSTS/stinkie-desktop/deploy.nix` registering the
      deploy-rs node
- [x] 1.8 Wipe the second-hand disk, LUKS2 format it, ext4 with `-m 0`, mount it
- [x] 1.9 Refresh the stale GitHub access token on stinkie
- [x] 1.10 Garbage-collect stinkie (94 GB used to 41 GB used)
- [x] 1.11 Reboot and verify: crypttab auto-unlock works, all four sleep targets
      masked, desktop services inactive, `nvidia-smi` works headless

## 2. Commit the applied work

- [x] 2.1 Commit the three modified/new files in `modules/HOSTS/stinkie-desktop/`
- [x] 2.2 Verify `rme deploy_remote stinkie` now succeeds from peterspav, which
      confirms the trusted-users fix end to end
- [x] 2.3 Remove the rsync'd working copy at `/home/pim/mipnix` on stinkie once
      2.2 passes
- [x] 2.4 `shred -u /tmp/p.txt` on peterspav

## 3. immich

- [x] 3.1 Create `/mnt/immich-data/immich` and
      `/mnt/immich-data/aperture-originals`, readable by the immich user
- [x] 3.2 Create `modules/HOSTS/stinkie-desktop/immich.nix` enabling
      `services.immich` with `mediaLocation` under `/mnt/immich-data`.
      No age secret: postgres is reached over a unix socket with peer auth
- [x] 3.3 Enable `services.immich.machine-learning`, running on CPU. Set
      `accelerationDevices` to the NVIDIA device nodes for NVENC transcoding
      only, not for ML
- [x] 3.4 Bind the service so it is reachable from the LAN and the mesh only
- [x] 3.5 Deploy and confirm the service starts, including that VectorChord
      loads on this CPU (vchord 1.1.1 loaded, /api/server/ping returns 200)
- [ ] 3.6 Register `stinkie = "192.168.100.17"` in `flake.nebulaNodes` if name
      resolution from other hosts is wanted

## 4. Seed the first batch (year 2002)

- [x] 4.1 Copy `aperture originals/2002` from piethein over SSH into
      `/mnt/immich-data/aperture-originals`. Used `tar` over SSH, not rsync:
      DSM's rsync service is disabled, so Synology's rsync refuses server mode
- [x] 4.2 Report file count and byte size actually transferred
      (5029 files, 3881503163 bytes, 240 s, exact match with the source).
      Of those only 4347 are photographs: 682 were Synology `@eaDir`
      thumbnails, since removed and excluded both in rsync and in immich
- [x] 4.3 Register the path in immich as a read-only external library
      (library 369d8e52, importPath /mnt/immich-data/aperture-originals,
      exclusionPatterns for @eaDir, .DS_Store, @SynoResource)
- [x] 4.4 Confirm thumbnails, search and face detection produce results
      (154 people detected, CLIP smart search returns hits, zero failed jobs)
- [ ] 4.5 Time the batch. Report the extrapolation to 31865 files as optimistic,
      since 2002 holds the library's smallest files

## 5. Full import

- [ ] 5.0 Enable "rsync service" in DSM (Control Panel, File Services, rsync)
      so the 91 GB transfer is resumable. Without it the fallback is `tar`,
      which restarts from zero if the stream dies
- [ ] 5.1 rsync the remaining years (all but `2002`) from piethein
- [ ] 5.2 Verify the transferred tree matches the source by file count and size
- [ ] 5.3 Confirm the year folders are unchanged after indexing, and that no
      storage template has renamed anything
- [ ] 5.4 Let the ML pass complete and record how long it took

## 6. Backups

- [ ] 6.1 Add `mipnix.backup.piethein` to stinkie covering both the database and
      the full media tree (the external library and immich's managed area)
- [ ] 6.2 Use `prepareCommand` to `pg_dump` the database and `cleanupCommand` to
      remove the dump
- [ ] 6.3 Add stinkie's datasets to `flake.resticRepos`
- [ ] 6.4 Add stinkie to the `systems` list and register its host key in
      `secrets/secrets.nix`, then `rme rekey`
- [ ] 6.5 Run one backup by hand and restore a single file to prove the repo

## 7. Verify

- [ ] 7.1 Reboot (with someone at the keyboard, see the boot requirement in the
      spec) and confirm: photo disk mounted, no sleep, GPU present, immich up
- [ ] 7.2 Confirm piethein's copy of `aperture-originals` is unchanged
- [ ] 7.3 Run `openspec validate add-immich-photo-host --strict`

## Deferred, not part of this change

Remote unlock of the root volume via `boot.initrd.network.ssh` is out of scope
while stinkie stays on wifi. NixOS initrd networking is wired-only, so it cannot
be implemented at all until `enp4s0` has a carrier. The analysis is kept in
`design.md` so the work is ready if a cable is ever run: it needs `r8169` added
to `boot.initrd.availableKernelModules`, an initrd host key on `/boot`, and
pim's public key authorized.
