# NixOS Configuration

I'm new to NixOS, and this repository contains my experiments with
the system and user configuration.

## Useful nix commands

* Build the system and switch  
  `sudo nixos-rebuild switch --flake .#flaked-nixos`

* Build the system, make it the new default, but don't switch to it
  yet (only at the next restart)  
  `sudo nixos-rebuild boot --flake .#flaked-nixos`

* Update only a single flake input
  `nix flake lock --update-input <name1> --update-input <name2> ...`

* Remove generations older than a given period  
  `sudo nix-collect-garbage --delete-older-than 15d`

* Remove all old generations (no rollback possible to old generations,
  use with caution)  
  `sudo nix-collect-garbage -d`

The remove commands above won't rebuild the GRUB configuration, so the old
entries remain in your boot menu. They get clean up if you rebuild the
system config again with one of the first commands. If you can't rebuild
the system locally (e.g. on a server), then you can use these two commands:
```
sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
sudo /nix/var/nix/profiles/system/bin/switch-to-configuration switch
```
