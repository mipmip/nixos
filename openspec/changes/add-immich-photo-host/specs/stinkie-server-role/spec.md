# stinkie-server-role Specification

## ADDED Requirements

### Requirement: stinkie runs headless and cannot suspend
stinkie SHALL import `role-server` and SHALL NOT import any desktop role. The
sleep, suspend, hibernate and hybrid-sleep targets SHALL be disabled at the
NixOS level rather than inhibited at runtime.

A runtime inhibitor is not sufficient: `systemctl mask --runtime` writes to
`/run/systemd/system`, which NixOS's own unit symlinks in `/etc/systemd/system`
outrank, so the units stay loaded. Only `systemd.targets.<name>.enable = false`
stops the symlink being created in the first place.

#### Scenario: The sleep targets are unavailable
- **WHEN** `systemctl show <unit> -p LoadState` is run on stinkie for
  `sleep.target`, `suspend.target`, `hibernate.target` and `hybrid-sleep.target`
- **THEN** each SHALL report `masked`

#### Scenario: An idle login screen cannot suspend the host
- **WHEN** no graphical session is configured
- **THEN** `display-manager.service`, `gdm.service` and `cups.service` SHALL be
  inactive
- **AND** no `gsd-power` process SHALL hold a sleep inhibitor

### Requirement: The GPU remains available without a display server
The NVIDIA driver SHALL stay configured after the desktop is removed, because
immich's machine-learning worker uses CUDA.

The nvidia module in nixpkgs is gated on `services.xserver.videoDrivers`, not on
`services.xserver.enable`, so listing the driver with X switched off is the
supported headless form.

#### Scenario: CUDA is usable headless
- **WHEN** `nvidia-smi` is run on stinkie
- **THEN** it SHALL report the GTX 1050 and its driver version
- **AND** `services.xserver.enable` SHALL be `false`

### Requirement: stinkie is deployable with deploy-rs
stinkie SHALL contribute a `flake.deploy` node and SHALL list `pim` in
`nix.settings.trusted-users`.

Without the trusted-users entry, `deploy` fails while copying the closure with
"cannot add path ... because it lacks a signature by a trusted key", because
paths built on the deploying machine are unsigned.

#### Scenario: The node is registered
- **WHEN** `nix eval .#deploy.nodes --apply builtins.attrNames` is evaluated
- **THEN** the result SHALL contain `stinkie`

#### Scenario: Unsigned paths are accepted
- **WHEN** `rme deploy_remote stinkie` copies a locally built closure
- **THEN** the copy SHALL succeed without signature errors

### Requirement: Booting stinkie requires physical presence
stinkie's root volume is LUKS-encrypted with no keyfile and no initrd SSH, so
every boot stops at the passphrase prompt until someone types it at the console.

This SHALL be treated as an operational constraint of the host, not as a defect
to be worked around by weakening the root encryption. Any reboot, whether
deliberate or as a side effect of an activation, SHALL be planned for a moment
when someone can be at the keyboard.

The constraint stands while stinkie is on wifi. NixOS initrd networking is
wired-only, carrying no wpa_supplicant, so remote unlock cannot be implemented
until `enp4s0` has a carrier. See `design.md` for what it would take.

#### Scenario: The boot halts without a human
- **WHEN** stinkie is rebooted or powered on
- **THEN** it SHALL halt in the initrd awaiting the root passphrase
- **AND** SHALL NOT appear on the network until that passphrase is entered

#### Scenario: Remote reboots are unsafe
- **WHEN** a reboot is considered from a remote session
- **THEN** the host SHALL be understood as unreachable afterwards until someone
  attends it physically
- **AND** this SHALL be checked before advising or issuing the reboot, not after

#### Scenario: An activation that demands a reboot
- **WHEN** `nixos-rebuild` reports a switch inhibitor such as a dbus
  implementation change
- **THEN** the new configuration SHALL be staged with `boot` rather than forced
  with `NIXOS_NO_CHECK`
- **AND** the reboot SHALL be left to a moment when the console is attended
