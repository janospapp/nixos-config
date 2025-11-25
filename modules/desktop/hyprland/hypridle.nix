{ config, lib, pkgs, pkgs-unstable, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    home-manager.users.${config.user.username}.services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock --grace 3";       # avoid starting multiple hyprlock instances.
          before_sleep_cmd = "loginctl lock-session";    # lock before suspend.
          after_sleep_cmd = "hyprctl dispatch dpms on";  # to avoid having to press a key twice to turn on the display.
        };

        listener = [
          {
            timeout = 600; # 10 min
            on-timeout = "~/.local/bin/is_video_playing.sh || loginctl lock-session"; # lock screen unless a video is playing
          }
          {
            timeout = 900; # 15 min
            on-timeout = "~/.local/bin/is_video_playing.sh || hyprctl dispatch dpms off"; # screen off when timeout has passed
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r"; # screen on when activity is detected after timeout has fired.
          }
        ];
      };
    };

    user.homePackages = [
      pkgs.playerctl
    ];

    user.homeFiles = {
      ".local/bin/is_video_playing.sh" = {
        source = ./scripts/is_video_playing.sh;
      };
    };
  };
}
