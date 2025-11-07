{ config, lib, inputs, outputs, system, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.backupFileExtension = "hm-bkp";
      home-manager.extraSpecialArgs = { inherit inputs outputs system; };
      home-manager.sharedModules = [ inputs.plasma-manager.homeModules.plasma-manager ];
    }
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
    ./nixos/configuration.nix
    ./desktop
    ./development.nix
    ./programs
    ./user.nix
    ./workTools.nix
  ];

  options.system = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = null;
      description = "The hostname of the system";
    };
  };
}
