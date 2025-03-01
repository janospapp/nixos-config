{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Vim plugins
    vim-arpeggio = {
      url = "github:kana/vim-arpeggio";
      flake = false;
    };
    vim-bundler = {
      url = "github:tpope/vim-bundler";
      flake = false;
    };
    vim-nerdtree-l-open-h-close = {
      url = "github:flw-cn/vim-nerdtree-l-open-h-close";
      flake = false;
    };
    vimux-ruby-test = {
      url = "github:janospapp/vimux-ruby-test";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, disko, nixos-hardware, ... }@inputs:
  let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;

    generateOsConfig = { system, hardware, extraModules ? [] }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs outputs system hardware; };

      modules = [
        ./nixos/configuration.nix
        ./nixos/hardware/${hardware}.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.extraSpecialArgs = { inherit inputs outputs system; };
          home-manager.users.${self.username} = import ./home-manager/home.nix;
          home-manager.sharedModules = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];
        }
      ] ++ extraModules;
    };
  in
  {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays { inherit inputs; };

    username = "janos";

    nixosConfigurations = {
      old-hp = generateOsConfig {
        system = "x86_64-linux";
        hardware = "old-hp";
        extraModules = [
          #./nixos/hardware/disko/standard.nix
          #disko.nixosModules.disko
        ];
      };

      dell-xps = generateOsConfig {
        system = "x86_64-linux";
        hardware = "dell-xps";
        extraModules = [
          ./nixos/hardware/disko/standard.nix
          disko.nixosModules.disko
          nixos-hardware.nixosModules.dell-xps-13-9310
        ];
      };
    };
  };
}
