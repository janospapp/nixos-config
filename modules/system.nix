{ config, lib, inputs, outputs, system, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.extraSpecialArgs = { inherit inputs outputs system; };
      home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
    }
    inputs.disko.nixosModules.disko
    ./home-manager/home.nix
    ./nixos/configuration.nix
    ./desktop.nix
    ./development.nix
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
