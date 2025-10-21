{ config, lib, ... }:
let
  cfg = config.desktop.plasma;
in
{
  config = lib.mkIf cfg.enable {
    home-manager.users.${config.user.username} = {
      programs = {
        plasma = {
          panels = [
            {
              location = "bottom";
              alignment = "center";
              lengthMode = "fit";
              height = 54;
              floating = true;
              hiding = "none";
              screen = 0;
              widgets = [
                {
                  kickoff = {
                    icon = "nix-snowflake";
                  };
                }
                {
                  iconTasks = {
                    launchers = cfg.dockLaunchers;
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
          ];
        };
      };
    };
  };
}
