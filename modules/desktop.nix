{ config, lib, pkgs, inputs, system, ... }:
let
  cfg = config.desktop;
  nordic = pkgs.nordic.overrideAttrs (old: {
    srcs = [
      (pkgs.fetchFromGitHub {
        owner = "janospapp";
        repo = "nordic";
        rev = "8b64a7733dd3456e259bc8bd6d6b48df8df06259";
        hash = "sha256-OF77tC650qI4qaOYCcQ3leO8wzz8mAvzvxAvrfLrxh0=";
        name = "Nordic";
      })
    ];
  });
in
{
  options = {
    desktop.enable = lib.mkEnableOption "Desktop";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Enable CUPS to print documents.
    services.printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    # Enable scanners
    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.epkowa ];
    };

    environment.systemPackages = with pkgs; [
      libreoffice
      simple-scan
    ];

    # Needed for pipewire to to acquire realtime priority of certain processes
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    user.homePackages = with pkgs; [
      inkscape
      nordic
      obsidian
      pinta
      spotify
    ];

    user.homeConfig = {
      firefox = {
        enable = true;
        profiles.${config.user.username} = {
          extensions = with inputs.firefox-addons.packages.${system}; [
            bitwarden
            plasma-integration
            ublock-origin
          ];

          settings = {
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "widget.use-xdg-desktop-portal.mime-handler" = 1;
          };
        };
      };

      plasma = {
        enable = true;

        input.keyboard = {
          layouts = [
            { layout = "us"; }
            { layout = "hu"; }
          ];
          numlockOnStartup = "on";
          options = [
            "caps:escape_shifted_capslock"
          ];
        };

        session = {
          restoreOpenApplicationsOnLogin = "onLastLogout";
        };

        workspace = {
          clickItemTo = "select";
          lookAndFeel = "Nordic-bluish";
        };

        panels = [
          # Dock
          {
            panelType = {
              location = "bottom";
              alignment = "center";
              lengthMode = "fit";
              height = 54;
              floating = "true";
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
                      selected = "Local";
                    };
                    calendar = {
                      firstDayOfWeek = "monday";
                      showWeekNumbers = true;
                    };
                  };
                }
              ];
            };
          }
        ];
      };
    };
  };
}
