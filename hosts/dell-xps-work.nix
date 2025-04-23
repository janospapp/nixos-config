{ inputs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/standard.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9310
    inputs.private-modules.nixosModules.dell-xps-work
  ];
}
