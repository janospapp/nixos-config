# NixOS Configuration

This repository contains my personal (and work) NixOS configuration.

## Useful nix commands

### Manage the system with the `nh` tool

* Build the system and switch
  `nh os switch`

* Build the system, make it the new default, but don't switch to it
  yet (only at the next restart)
  `nh os boot`

* Remove old generations (keey at least N)
  `nh clean keep N`

### Manage flakes

* Update all flake inputs
  `nix flake update`

* Update only a single flake input
  `nix flake lock --update-input <name1> --update-input <name2> ...`

### Nix shells

* Run a specific program
  `nix shell nixpkgs#my-program-to-run`

### Build custom ISO

To build a bootable ISO from specific system configuration it must exist
in the flake outputs (e.g. `packages.x86_64-linux.dellIso`). Then it can
be built like any standard item from a flake, i.e.
```
nix build .#packages.x86_64-linux.dellIso
```

It will create a `result` directory with `iso` in it, that will contain the
image file. It can be copied to a USB drive with the `dd` command, e.g.
```
sudo dd if=./result/iso/<the generated name>.iso of=/dev/sdX bs=4M status=progress oflag=sync
```
**Note**: The device must be provided as the output (e.g. `sda`) and not a partition (i.e. `sda1`,
`sda2`, etc.). The ISO already contains the entire partition scheme with a proper boot partition.

You can verify the result with `lsblk`, you should see something like this:
```
❯ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    1  29.3G  0 disk
├─sda1        8:1    1   4.4G  0 part
└─sda2        8:2    1     3M  0 part
```
If you don't see `sda1` and `sda2` partitions then the ISO image is not correct.

I use the `installation-cd-graphical-base.nix` installer, while many articles suggest
to use `installation-cd-minimal.nix`. Both should work. I tried `iso-image.nix`, but
it generated an incorrect ISO that I couldn't boot from the USB drive.
