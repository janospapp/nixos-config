{ config, lib, pkgs-unstable, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    home-manager.users.${config.user.username}.wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;

      settings = {
        # MONITORS
        monitor = [
          "eDP-1,$LAPTOP_RESOLUTION,2560x0,1"
          "$EXTERNAL_MONITOR_ID,2560x1440@60,0x0,1"
        ];

        # MY PROGRAMS
        "$terminal" = "kitty tmux";
        "$browser" = "firefox";
        "$fileManager" = "kitty yazi";
        "$menu" = "rofi -show drun";

        # AUTOSTART
        exec-once = [
          "hyprpanel"
          "hypridle"
        ];

        # ENVIRONMENT VARIABLES
        env = [
          "XCURSOR_THEME,Nordzy-cursors"
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_THEME,Nordzy-cursors"
          "HYPRCURSOR_SIZE,24"
        ];

        # LOOK AND FEEL
        general = {
          gaps_in = 3;
          gaps_out = 20;

          border_size = 2;

          resize_on_border = true;

          allow_tearing = false;

          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;

            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = "yes, please :)";

          bezier = [
            #NAME,           X0,   Y0,   X1,   Y1
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];

          animation = [
            #NAME,          ONOFF, SPEED, CURVE,        [STYLE]
            "global,        1,     10,    default"
            "border,        1,     5.39,  easeOutQuint"
            "windows,       1,     4.79,  easeOutQuint"
            "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
            "windowsOut,    1,     1.49,  linear,       popin 87%"
            "fadeIn,        1,     1.73,  almostLinear"
            "fadeOut,       1,     1.46,  almostLinear"
            "fade,          1,     3.03,  quick"
            "layers,        1,     3.81,  easeOutQuint"
            "layersIn,      1,     4,     easeOutQuint, fade"
            "layersOut,     1,     1.5,   linear,       fade"
            "fadeLayersIn,  1,     1.79,  almostLinear"
            "fadeLayersOut, 1,     1.39,  almostLinear"
            "workspaces,    1,     1.94,  almostLinear, fade"
            "workspacesIn,  1,     1.21,  almostLinear, fade"
            "workspacesOut, 1,     1.94,  almostLinear, fade"
            "zoomFactor,    1,     7,     quick"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = -1;
          disable_hyprland_logo = false;
        };

        # INPUT
        input = {
          kb_layout = "us,hu";
          kb_variant = "";
          kb_model = "";
          kb_options = "caps:escape_shifted_capslock,grp:alt_shift_toggle";
          kb_rules = "";

          numlock_by_default = true;

          follow_mouse = 2;

          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
          };
        };

        gesture = "3, horizontal, workspace";

        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        # KEYBINDINGS
        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, W, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, V, togglefloating,"
          "$mainMod, space, fullscreen, 1"
          "$mainMod, F11, fullscreen"
          "$mainMod, escape, exec, hyprlock --grace 2"

          "$mainMod, Return, exec, $terminal"
          "$mainMod, B, exec, $browser"
          "$mainMod, E, exec, $fileManager"
          "Alt, space, exec, $menu"
          "Alt, S, exec, rofi -show ssh"
          "Alt, E, exec, rofi -show emoji"
          "Alt, C, exec, rofi -show calc"
          "$mainMod, P, pseudo, # dwindle"

          "$mainMod, h, movefocus, l"
          "$mainMod, j, movefocus, d"
          "$mainMod, k, movefocus, u"
          "$mainMod, l, movefocus, r"

          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, L, movewindow, r"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, J, movewindow, d"

          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"
        ];

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Laptop multimedia keys for volume and LCD brightness
        bindel = [
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];

        # Requires playerctl
        bindl = [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
        ];

        # WINDOWS AND WORKSPACES
        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];

        workspace = [
          "1, monitor:$EXTERNAL_MONITOR_ID, persistent:true, on-created-empty: $terminal"
          "2, monitor:$EXTERNAL_MONITOR_ID, persistent:true, on-created-empty: $browser"
          "3, monitor:$EXTERNAL_MONITOR_ID, persistent:true"
          "4, monitor:$EXTERNAL_MONITOR_ID"
          "5, monitor:$EXTERNAL_MONITOR_ID"
          "6, monitor:eDP-1, persistent:true, on-created-empty: spotify"
          "7, monitor:eDP-1, persistent:true"
          "8, monitor:eDP-1, persistent:true"
          "9, monitor:eDP-1"
        ];

        windowrulev2 = [
          "pseudo size 1520 900,class:^(Spotify)$"
          "float, class:^(com.gabm.satty)$"
          "minsize 1200 600,class:^(com.gabm.satty)$"
        ];
      };
    };
  };
}
