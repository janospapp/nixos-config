{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    nixarr.url = "github:rasmus-kirk/nixarr";

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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, disko, nixos-hardware, ... }@inputs:
  let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    username = "janos";

    forAllSystems = nixpkgs.lib.genAttrs systems;

    generateOsConfig = { system, hostModule }: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs outputs system;
        pkgs-unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      modules = [
        ./modules/system.nix
        hostModule
      ];
    };
  in
  {
    overlays = import ./overlays { inherit inputs; };

    nixosConfigurations = {
      dell-xps = generateOsConfig {
        system = "x86_64-linux";
        hostModule = ./hosts/dell-xps.nix;
      };

      darter-pro-work = generateOsConfig {
        system = "x86_64-linux";
        hostModule = ./hosts/darter-pro-work.nix;
      };

      roxxy = generateOsConfig {
        system = "x86_64-linux";
        hostModule = ./hosts/roxxy.nix;
      };
    };

    packages.x86_64-linux.dellIso = let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      self.nixosConfigurations.dell-xps.config.system.build.isoImage;
  };
}
