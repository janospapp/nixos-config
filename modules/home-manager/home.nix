{ config, lib, pkgs, inputs, outputs, system, ... }:
let
  username = config.user.username;
in {
  imports = [
    ./core
  ];

  home-manager.users.${username} = {
    home = let
      localPackages = with outputs.packages.${system}; [
        plasma-panel-templates
      ];
    in {
      inherit username;
      homeDirectory = "/home/${username}";

      stateVersion = config.system.stateVersion;
      packages = config.user.homePackages ++ localPackages;
    };

    programs = {
      home-manager.enable = true;
    } // config.user.homeConfig;

    services = {
      syncthing = {
        enable = true;
        tray.enable = true;
      };
    };
  };
}
