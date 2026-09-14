{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop.niri;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    user.homePrograms.noctalia = {
      enable = true;

      settings = {
        bar = {
          default = {
            background_opacity = 0.95;
            capsule = true;
            capsule_border = "tertiary";
            capsule_padding = 11;
            capsule_radius = 5;
            capsule_thickness = 0.65;
            center = [ ];
            color = "primary";
            end = [
              "notes"
              "recorder"
              "notifications"
              "clipboard"
              "network"
              "bluetooth"
              "volume"
              "battery"
              "control-center"
              "session"
              "clock"
            ];
            font_family = "NotoSans Nerd Font";
            icon_color = "primary";
            padding = 22;
            scale = 1.1;
            start = [
              "launcher"
              "workspaces"
              "media"
            ];
            thickness = 44;
            widget_spacing = 15;
          };
        };

        idle = {
          behavior_order = [
            "lock"
            "screen-off"
            "lock-and-suspend"
          ];

          pre_action_fade_seconds = 5;

          behavior = {
            lock = {
              action = "lock";
              enabled = true;
              timeout = 600;
            };

            "lock-and-suspend" = {
              action = "lock_and_suspend";
              enabled = false;
              timeout = 900;
            };

            "screen-off" = {
              action = "screen_off";
              enabled = true;
              timeout = 1800;
            };
          };
        };

        plugin_settings = {
          "noctalia/notes" = {
            panel_open_near_click = true;
          };

          "yuuto/calculator" = {
            panel_open_near_click = false;
            panel_placement = "floating";
          };
        };

        plugins = {
          enabled = [
            "yuuto/calculator"
            "noctalia/notes"
            "noctalia/translator"
            "noctalia/bitwarden"
            "noctalia/screen_recorder"
          ];
        };

        shell = {
          app_icon_color = "tertiary";

          panel = {
            open_near_click_control_center = true;
            open_near_click_session = true;
          };
        };

        theme = {
          builtin = "Nord";
          community_palette = "Oxocarbon";
          mode = "dark";
          source = "builtin";
          wallpaper_scheme = "m3-content";
        };

        widget = {
          network = {
            show_label = false;
          };

          notes = {
            type = "noctalia/notes:notes";
          };

          recorder = {
            type = "noctalia/screen_recorder:recorder";
          };
        };
      };
    };

    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    user.homePackages = [
      pkgs.gpu-screen-recorder # Needed for the screen recorder plugin
    ];
  };
}
