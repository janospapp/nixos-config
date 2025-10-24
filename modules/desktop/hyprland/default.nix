{ config, lib, pkgs-unstable, ... }:
let
  cfg = config.desktop.hyprland;
in
{
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
      grim # For taking screenshots
      hyprland-protocols
      hyprpanel
      rofi # Application runner
      satty # Screenshot annotation tool
      slurp # Select area for screenshots
      wl-clipboard
    ];

    ## Not available in HM 25.05, only on unstable.
    ## Uncomment once it's available or switched to unstable
    #user.homePrograms = {
    #  satty = {
    #    enable = true;
    #    settings = {
    #      general = {
    #        copy-command = "wl-copy";
    #        corner-roundness = 12;
    #        early-exit = true;
    #        initial-tool = "brush";
    #        fullscreen = true;
    #        output-filename = "/home/${config.user.username}/Pictures/Screenshots/screenshot_%Y-%m-%d_%H:%M:%S.png";
    #      };
    #      color-palette = {
    #        palette = [ "#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000" ];
    #      };
    #    };
    #  };
    #};

    home-manager.users.${config.user.username}.home = {
      file = {
        ".local/bin/screenshot.sh" = {
          source = ./scripts/screenshot.sh;
        };
      };
    };
  };
}
