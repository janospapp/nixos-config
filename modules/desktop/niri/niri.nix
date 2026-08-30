{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop.niri;
in
{
  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    user.homePrograms.niri = {
      settings = {
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;

        input.keyboard = {
          numlock = true;
          xkb = {
            options = "caps:escape_shifted_capslock,grp:alt_shift_toggle";
            layout = "us,hu";
          };
        };

        binds = import ./binds.nix;

        spawn-at-startup = [
          { argv = ["noctalia"]; }
          { sh = "kitty tmux"; }
          { argv = ["spotify"]; }
          { argv = ["firefox"]; }
        ];

        cursor = {
          theme = "Nordzy-cursors";
          size = 24;
        };

        layout = import ./layout.nix;

        workspaces = import ./workspaces.nix;

        window-rules = import ./window-rules.nix;
      };
    };

    user.homePackages = with pkgs; [
      # Needed for media keys
      brightnessctl
      playerctl
    ];

    user.homeXdg = {
      # Fixing file chooser
      portal = {
        enable = true;

        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];

        config.niri = {
          "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };
    };
  };
}
