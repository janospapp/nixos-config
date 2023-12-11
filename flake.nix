{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nerdtree-l-open-h-close = {
      url = "github:flw-cn/vim-nerdtree-l-open-h-close";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;

    generateOsConfig = { system, hardware, extraModules ? [] }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs outputs system; };

      modules = [
        ./nixos/configuration.nix
        ./nixos/hardware/${hardware}.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = { inherit inputs outputs system; };
          home-manager.users.janos = import ./home-manager/home.nix;
          home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
        }
      ] ++ extraModules;
    };
  in
  {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      virtualbox = generateOsConfig {
        system = "x86_64-linux";
        hardware = "virtualbox";
      };

      old-hp = generateOsConfig {
        system = "x86_64-linux";
        hardware = "old-hp";
        extraModules = [
          ./nixos/hardware/disko/standard.nix
        ];
      };
    };
  };
}
