{ inputs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/standard.nix
    inputs.nixos-hardware.nixosModules.system76-darp6
    inputs.private-modules.nixosModules.darter-pro-work
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.system76.darp6 = {
    soundVendorId = "0x10ec0293";
    soundSubsystemId = "0x15581404";
  };
}
