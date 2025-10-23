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
    plasma = {
      enable = true;
      dockLaunchers = [
        applications:systemsettings.desktop
        applications:spotify.desktop
        applications:kitty.desktop
        preferred://browser
        preferred://filemanager
        applications:org.kde.spectacle.desktop
        applications:org.kde.kate.desktop
        applications:obsidian.desktop
      ];
    };
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
}
