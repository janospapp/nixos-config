{ inputs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/standard.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9310
  ];

  desktop.enable = true;
  workTools.enable = true;
  user = {
    username = "janos";
    name = "Janos Papp";
    email = builtins.getEnv "WORK_EMAIL";
  };
  system = {
    hostname = "dell-xps";
  };
}
