{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop.niri;
in
{
  imports = [
    inputs.niri.nixosModules.niri
    ./noctalia.nix
  ];

  options = {
    desktop.niri = {
      enable = lib.mkEnableOption "Niri";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    user.homePrograms.niri = {
      settings = {
        binds = {
          "Mod+Shift+Slash".action.show-hotkey-overlay = [];

          "Mod+H".action.focus-column-left = [];
          "Mod+J".action.focus-window-down = [];
          "Mod+K".action.focus-window-up = [];
          "Mod+L".action.focus-column-right = [];

          "Mod+Shift+H".action.move-column-left = [];
          "Mod+Shift+J".action.move-window-down = [];
          "Mod+Shift+K".action.move-window-up = [];
          "Mod+Shift+L".action.move-column-right = [];

          "Mod+O" = {
            action.toggle-overview = [];
            repeat = false;
          };
          "Mod+W" = {
            action.close-window = [];
            repeat = false;
          };

          "Mod+T".action.spawn-sh = "kitty tmux";
          "Alt+Space".action.spawn-sh = ["noctalia msg panel-toggle launcher"];
          "Mod+Space".action.fullscreen-window = [];
          "Mod+M".action.maximize-column = [];
          "Mod+Shift+E".action.quit = [];
        };

        input.keyboard = {
          numlock = true;
          xkb = {
            options = "caps:escape_shifted_capslock,grp:alt_shift_toggle";
            layout = "us,hu";
          };
        };

        spawn-at-startup = [
          { argv = ["noctalia"]; }
        ];
      };
    };
  };
}

