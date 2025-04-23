{ inputs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/standard.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9310
  ];

  desktop.enable = true;
  development.enable = true;
  user = {
    username = "janos";
    name = "Janos Papp";
    email = "papp.janos.90@gmail.com";
  };
  system = {
    hostname = "dell-xps";
  };
}
