{ config, lib, pkgs, ... }:
let
  cfg = config.desktop.hyprland;
in
{
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprpanel.nix
    ./screenshot.nix
  ];

  options = {
    desktop.hyprland = {
      enable = lib.mkEnableOption "Hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
        package = pkgs.hyprland;
      };
      hyprlock = {
        enable = true;
        package = pkgs.hyprlock;
      };
    };
    environment.systemPackages = with pkgs; [
      hyprland-protocols
      kdePackages.okular # PDF viewer
      nordzy-cursor-theme
      wl-clipboard
    ];
    environment.variables = {
      XCURSOR_THEME = "Nordzy-cursors";
      XCURSOR_SIZE = "24";
    };

    # I provide my own theme below
    user.stylixTargets.rofi.enable = false;

    user.homePrograms = {
      rofi = {
        enable = true;
        extraConfig = {
          modes = "window,drun,run,ssh,calc,emoji,nerdy";
          kb-remove-to-eol = ""; # remove Control+k default
          kb-accept-entry = "Control+m,Return,KP_Enter"; # remove Control+j default
          kb-row-down = "Down,Control+n,Control+j";
          kb-row-up = "Up,Control+p,Control+k";
        };
        plugins = with pkgs; [
          rofi-calc
          rofi-emoji
          rofi-nerdy
        ];
        theme = "rounded-nord-dark";
      };
    };

    user.homeFiles = {
      # Themes from https://github.com/newmanls/rofi-themes-collection
      ".local/share/rofi/themes" = {
        source = ./rofi/themes;
        recursive = true;
      };
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
