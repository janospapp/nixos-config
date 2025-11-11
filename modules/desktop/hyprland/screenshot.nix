{ config, lib, pkgs-unstable, ... }:
{
  config = lib.mkIf config.desktop.hyprland.enable {
    environment.systemPackages = with pkgs-unstable; [
      grim # For taking screenshots
      satty # Screenshot annotation tool
      slurp # Select area for screenshots
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

    ## Use this config file for now.
    user.homeFiles = {
      ".local/bin/screenshot.sh" = {
        source = ./scripts/screenshot.sh;
      };

      ".local/config/satty/config.toml" = {
        text = ''
          [general]
          # Start Satty in fullscreen mode
          fullscreen = false
          # Exit directly after copy/save action
          early-exit = true
          # Draw corners of rectangles round if the value is greater than 0 (0 disables rounded corners)
          corner-roundness = 12
          # Select the tool on startup [possible values: pointer, crop, line, arrow, rectangle, text, marker, blur, brush]
          initial-tool = "brush"
          # Configure the command to be called on copy, for example `wl-copy`
          copy-command = "wl-copy"
          # Increase or decrease the size of the annotations
          annotation-size-factor = 2
          # Filename to use for saving action. Omit to disable saving to file. Might contain format specifiers: https://docs.rs/chrono/latest/chrono/format/strftime/index.html
          # starting with 0.20.0, can contain leading tilde (~) for home directory
          output-filename = "$HOME/Pictures/Screenshots/screenshot_%Y-%m-%d_%H:%M:%S.png"
          # After copying the screenshot, save it to a file as well
          save-after-copy = false
          # Hide toolbars by default
          default-hide-toolbars = false
          # The primary highlighter to use, the other is accessible by holding CTRL at the start of a highlight [possible values: block, freehand]
          primary-highlighter = "block"
          # Disable notifications
          disable-notifications = false
          # Actions to trigger on right click (order is important)
          # [possible values: save-to-clipboard, save-to-file, exit]
          actions-on-right-click = []
          # Actions to trigger on Enter key (order is important)
          # [possible values: save-to-clipboard, save-to-file, exit]
          actions-on-enter = ["save-to-clipboard"]
          # Actions to trigger on Escape key (order is important)
          # [possible values: save-to-clipboard, save-to-file, exit]
          actions-on-escape = ["exit"]
          # request no window decoration. Please note that the compositor has the final say in this. At this point. requires xdg-decoration-unstable-v1.
          no-window-decoration = true
          # experimental feature: adjust history size for brush input smooting (0: disabled, default: 0, try e.g. 5 or 10)
          brush-smooth-history-size = 10

          # Font to use for text annotations
          [font]
          family = "Roboto"
          style = "Regular"

          # Custom colours for the colour palette
          [color-palette]
          # These will be shown in the toolbar for quick selection
          palette = [
              "#00ffff",
              "#a52a2a",
              "#dc143c",
              "#ff1493",
              "#ffd700",
              "#008000",
          ]

          # These will be available in the color picker as presets
          # Leave empty to use GTK's default
          custom = []
        '';
      };
    };
  };
}
