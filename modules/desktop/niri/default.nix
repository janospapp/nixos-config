{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop.niri;
in
{
  imports = [
    inputs.niri.nixosModules.niri
    ../screenshot
    ./niri.nix
    ./noctalia.nix
  ];

  options.desktop.niri.enable = lib.mkEnableOption "Niri";

  config = lib.mkIf cfg.enable {
    desktop.screenshot.enable = true;

    environment = {
      systemPackages = with pkgs; [
        kdePackages.okular # PDF viewer
        nordzy-cursor-theme
      ];
    };

    user.homeXdg = {
      mimeApps = {
        enable = true;
        defaultApplications = {
          "application/pdf" = "org.kde.okular.desktop";
        };
      };
    };
  };
}

