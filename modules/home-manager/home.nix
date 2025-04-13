{ config, lib, pkgs, inputs, outputs, system, ... }:
let
  username = config.users.username;
  desktopEnabled = config.desktop.enable;
in {
  home-manager.users.${username} = {
    home = let
      localPackages = with outputs.packages.${system}; [
        plasma-panel-templates
      ];
    in {
      inherit username;
      homeDirectory = "/home/${username}";

      stateVersion = config.system.stateVersion;
      packages = with pkgs; [
        devenv
        inkscape
        nordic
        obsidian
        papirus-icon-theme
        pinta
        slack
        spotify
        teams-for-linux
      ] ++ localPackages;
    };

    programs = let
      desktopConfig = lib.mkIf desktopEnabled {
        firefox = {
          enable = true;
          profiles.${username} = {
            extensions = with inputs.firefox-addons.packages.${system}; [
              bitwarden
              plasma-integration
              ublock-origin
            ];

            settings = {
              "widget.use-xdg-desktop-portal.file-picker" = 1;
              "widget.use-xdg-desktop-portal.mime-handler" = 1;
            };
          };
        };

        plasma = {
          enable = true;
          workspace.clickItemTo = "select";

          configFile = {
            kdeglobals = {
              Icons.Theme = "Papirus-Dark";
              KDE.LookAndFeelPackage = "Nordic-bluish";
            };
          };
        };
      };
    in {
      home-manager.enable = true;

      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    } // desktopConfig // import ./core pkgs;

    services = {
      syncthing = {
        enable = true;
        tray.enable = true;
      };
    };
  };
}
