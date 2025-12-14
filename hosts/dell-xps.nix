{ inputs, pkgs, ... }:
{
  imports = [
    ../modules/nixos/hardware/disko/standard.nix
    ../modules/nixos/filesystems/dell-xps.nix
    inputs.nixos-hardware.nixosModules.dell-xps-13-9310
  ];

  desktop = {
    enable = true;
    hyprland.enable = true;
    plasma.enable = false;
  };
  development.enable = true;
  user = {
    username = "janos";
    name = "Janos Papp";
    email = "papp.janos.90@gmail.com";
    timeZone = "Europe/Budapest";
  };
  system = {
    hostname = "dell-xps";
  };
  environment.sessionVariables = {
    EXTERNAL_MONITOR_ID = "DP-7";
    LAPTOP_RESOLUTION = "1920x1200@60";
  };
}
