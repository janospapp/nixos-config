{
  "Mod+Shift+Slash".action.show-hotkey-overlay = [];

  # Application hotkeys
  "Mod+Return".action.spawn-sh = "kitty tmux";
  "Mod+B".action.spawn = "firefox";
  "Mod+E".action.spawn-sh = "kitty yazi";

  "Alt+Space".action.spawn-sh = ["noctalia msg panel-toggle launcher"];
  "Alt+P".action.spawn-sh = "~/.local/bin/screenshot.sh";
  "Alt+N".action.spawn-sh = "noctalia msg panel-toggle noctalia/notes:panel";
  "Alt+C".action.spawn-sh = "noctalia msg panel-toggle yuuto/calculator:panel";
  "Alt+R".action.spawn-sh = "noctalia msg plugin noctalia/screen_recorder:service all start portal";
  "Mod+Shift+E".action.quit = [];

  "Mod+Space".action.fullscreen-window = [];
  "Mod+M".action.maximize-column = [];
  "Mod+R".action.switch-preset-column-width = [];
  "Mod+F".action.toggle-window-floating = [];

  # Move around
  "Mod+H".action.focus-column-left = [];
  "Mod+J".action.focus-workspace-down = [];
  "Mod+K".action.focus-workspace-up = [];
  "Mod+L".action.focus-column-right = [];

  "Mod+Shift+H".action.move-column-left = [];
  "Mod+Shift+J".action.move-workspace-down = [];
  "Mod+Shift+K".action.move-workspace-up = [];
  "Mod+Shift+L".action.move-column-right = [];
  "Mod+Tab".action.focus-monitor-next = [];
  "Mod+Shift+Tab".action.move-window-to-monitor-next = [];
  "Mod+Ctrl+Tab".action.move-column-to-monitor-next = [];

  "Mod+1".action.focus-workspace = 1;
  "Mod+2".action.focus-workspace = 2;
  "Mod+3".action.focus-workspace = 3;
  "Mod+4".action.focus-workspace = 4;
  "Mod+5".action.focus-workspace = 5;
  "Mod+6".action.focus-workspace = 6;
  "Mod+7".action.focus-workspace = 7;
  "Mod+8".action.focus-workspace = 8;
  "Mod+9".action.focus-workspace = 9;
  "Mod+Shift+1".action.move-window-to-workspace = 1;
  "Mod+Shift+2".action.move-window-to-workspace = 2;
  "Mod+Shift+3".action.move-window-to-workspace = 3;
  "Mod+Shift+4".action.move-window-to-workspace = 4;
  "Mod+Shift+5".action.move-window-to-workspace = 5;
  "Mod+Shift+6".action.move-window-to-workspace = 6;
  "Mod+Shift+7".action.move-window-to-workspace = 7;
  "Mod+Shift+8".action.move-window-to-workspace = 8;
  "Mod+Shift+9".action.move-window-to-workspace = 9;
  "Mod+Ctrl+1".action.move-column-to-workspace = 1;
  "Mod+Ctrl+2".action.move-column-to-workspace = 2;
  "Mod+Ctrl+3".action.move-column-to-workspace = 3;
  "Mod+Ctrl+4".action.move-column-to-workspace = 4;
  "Mod+Ctrl+5".action.move-column-to-workspace = 5;
  "Mod+Ctrl+6".action.move-column-to-workspace = 6;
  "Mod+Ctrl+7".action.move-column-to-workspace = 7;
  "Mod+Ctrl+8".action.move-column-to-workspace = 8;
  "Mod+Ctrl+9".action.move-column-to-workspace = 9;

  "Mod+O" = {
    action.toggle-overview = [];
    repeat = false;
  };
  "Mod+W" = {
    action.close-window = [];
    repeat = false;
  };

  # Media keys
  "XF86AudioPlay" = {
    action.spawn-sh = "playerctl play-pause";
    allow-when-locked = true;
  };
  "XF86AudioStop" = {
    action.spawn-sh = "playerctl stop";
    allow-when-locked = true;
  };
  "XF86AudioPrev" = {
    action.spawn-sh = "playerctl previous";
    allow-when-locked = true;
  };
  "XF86AudioNext" = {
    action.spawn-sh = "playerctl next";
    allow-when-locked = true;
  };
  "XF86AudioRaiseVolume" = {
    action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0";
    allow-when-locked = true;
  };
  "XF86AudioLowerVolume" = {
    action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";
    allow-when-locked = true;
  };
  "XF86AudioMute" = {
    action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    allow-when-locked = true;
  };
  "XF86AudioMicMute" = {
    action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
    allow-when-locked = true;
  };

  "XF86MonBrightnessUp" = {
    action.spawn = ["brightnessctl" "--class=backlight" "set" "+5%"];
    allow-when-locked = true;
  };
  "XF86MonBrightnessDown" = {
    action.spawn = ["brightnessctl" "--class=backlight" "set" "5%-"];
    allow-when-locked = true;
  };
}
