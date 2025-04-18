{ config, lib, pkgs, inputs, outputs, system, ... }:
let
  username = config.users.username;
  desktopEnabled = config.desktop.enable;
  nordic = pkgs.nordic.overrideAttrs (old: {
    srcs = [
      (pkgs.fetchFromGitHub {
        owner = "janospapp";
        repo = "nordic";
        rev = "8b64a7733dd3456e259bc8bd6d6b48df8df06259";
        hash = "sha256-OF77tC650qI4qaOYCcQ3leO8wzz8mAvzvxAvrfLrxh0=";
        name = "Nordic";
      })
    ];
  });
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
      packages = with pkgs; [
        inkscape
        nordic
        obsidian
        papirus-icon-theme
        pinta
        spotify
        teams-for-linux
        slack
        devenv
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
    } // desktopConfig;

    services = {
      syncthing = {
        enable = true;
        tray.enable = true;
      };
    };
  };
}
