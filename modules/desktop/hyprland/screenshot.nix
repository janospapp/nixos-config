{ config, lib, pkgs-unstable, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    environment.systemPackages = with pkgs-unstable; [
      grim # For taking screenshots
      satty # Screenshot annotation tool
      slurp # Select area for screenshots
    ];

    user.homePrograms = {
      satty = {
        enable = true;
        settings = {
          general = {
            copy-command = "wl-copy";
            corner-roundness = 12;
            early-exit = true;
            initial-tool = "brush";
            fullscreen = false;
            output-filename = "/home/${config.user.username}/Pictures/Screenshots/screenshot_%Y-%m-%d_%H:%M:%S.png";
          };
          color-palette = {
            palette = [ "#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000" ];
          };
        };
      };
    };

    user.homeFiles = {
      ".local/bin/screenshot.sh" = {
        source = ./scripts/screenshot.sh;
      };
    };
  };
}
