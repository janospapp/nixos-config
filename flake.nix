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
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    private-modules = {
      url = "git+http://gitea.home/janos/nixos-config";
      inputs.nixpkgs.follows = "nixpkgs";
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
    username = "janos";

    forAllSystems = nixpkgs.lib.genAttrs systems;

    generateOsConfig = { system, hardware, hostModule }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs outputs system hardware; };
      modules = [
        ./modules/system.nix
        hostModule
      ];
    };
  in
  {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      dell-xps = generateOsConfig {
        system = "x86_64-linux";
        hardware = "dell-xps";
        hostModule = ./hosts/dell-xps.nix;
      };

      dell-xps-work = generateOsConfig {
        system = "x86_64-linux";
        hardware = "dell-xps";
        hostModule = ./hosts/dell-xps-work.nix;
      };
    };
  };
}
