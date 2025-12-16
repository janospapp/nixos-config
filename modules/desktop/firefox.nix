{ config, lib, inputs, system, ... }:
{
  config = lib.mkIf config.desktop.enable {
    user.homePrograms = {
      firefox = {
        enable = true;
        profiles.${config.user.username} = {
          extensions.packages = with inputs.firefox-addons.packages.${system}; [
            bitwarden
            plasma-integration
            ublock-origin
          ];

          settings = {
            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.page" = 3;
            "browser.toolbars.bookmarks.visibility" = "always";
            "browser.translations.neverTranslateLanguages" = "hu";
            "extensions.autoDisableScopes" = 0;
            "signon.rememberSignons" = false;
            "widget.use-xdg-desktop-portal.file-picker" = 1;
            "widget.use-xdg-desktop-portal.mime-handler" = 1;
          };
        };
      };
    };

    user.homeXdg = {
      mimeApps = {
        enable = true;
        associations.added = {
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/chrome" = "firefox.desktop";
        };
        defaultApplications = {
          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "x-scheme-handler/chrome" = "firefox.desktop";
          "text/html" = "firefox.desktop";
          "application/x-extension-htm" = "firefox.desktop";
          "application/x-extension-html" = "firefox.desktop";
          "application/x-extension-shtml" = "firefox.desktop";
          "application/xhtml+xml" = "firefox.desktop";
          "application/x-extension-xhtml" = "firefox.desktop";
          "application/x-extension-xht" = "firefox.desktop";
        };
      };
    };

    user.stylixTargets.firefox.profileNames = [ config.user.username ];
  };
}
