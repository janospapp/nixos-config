{ inputs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/standard.nix
    inputs.nixos-hardware.nixosModules.system76-darp6
    inputs.private-modules.nixosModules.darter-pro-work
  ];
}
