# NixOS Configuration

I'm new to NixOS, and this repository contains my experiments with
the system and user configuration.

## Useful nix commands

* Build the system and switch  
  `sudo nixos-rebuild switch --flake .#flaked-nixos`

* Build the system, make it the new default, but don't switch to it
  yet (only at the next restart)  
  `sudo nixos-rebuild boot --flake .#flaked-nixos`

* Remove generations older than a given period  
  `sudo nix-collect-garbage --delete-older-than 15d`

* Remove all old generations (no rollback possible to old generations,
  use with caution)  
  `sudo nix-collect-garbage -d`
