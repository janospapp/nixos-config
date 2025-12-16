{ config, lib, pkgs-unstable, ... }:
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
        package = pkgs-unstable.hyprland;
      };
      hyprlock = {
        enable = true;
        package = pkgs-unstable.hyprlock;
      };
    };
    environment.systemPackages = with pkgs-unstable; [
      hyprland-protocols
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
          kb-remove-to-eol = ""; # remove Control+k default
          kb-accept-entry = "Control+m,Return,KP_Enter"; # remove Control+j default
          kb-row-down = "Down,Control+n,Control+j";
          kb-row-up = "Up,Control+p,Control+k";
        };
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
  };
}
