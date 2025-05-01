{
  location = "bottom";
  alignment = "center";
  lengthMode = "fit";
  height = 54;
  floating = true;
  hiding = "none";
  widgets = [
    {
      kickoff = {
        icon = "nix-snowflake";
      };
    }
    {
      iconTasks = {
        launchers = [
          applications:systemsettings.desktop
          applications:spotify.desktop
          applications:kitty.desktop
          preferred://browser
          preferred://filemanager
          applications:org.kde.spectacle.desktop
          applications:obsidian.desktop
          # Only for work
          applications:teams-for-linux.desktop
          applications:slack.desktop
        ];
        appearance = {
          showTooltips = true;
          highlightWindows = true;
          indicateAudioStreams = true;
          fill = true;
          iconSpacing = "medium";
        };
        behavior = {
          grouping = {
            method = "byProgramName";
            clickAction = "cycle";
          };
          sortingMethod = "manually";
          minimizeActiveTaskOnClick = true;
          wheel = {
            switchBetweenTasks = true;
            ignoreMinimizedTasks = true;
          };
          showTasks = {
            onlyInCurrentDesktop = true;
            onlyInCurrentActivity = true;
          };
        };
      };
    }
    {
      keyboardLayout = {
        displayStyle = "label";
      };
    }
    {
      digitalClock = {
        date = {
          enable = true;
          format = "isoDate";
          position = "belowTime";
        };
        time = {
          format = "24h";
        };
        timeZone = {
          selected = ["Local"];
        };
        calendar = {
          firstDayOfWeek = "monday";
          showWeekNumbers = true;
        };
      };
    }
  ];
}
