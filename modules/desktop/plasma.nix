{ config, lib, pkgs, ... }:
let
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
  config = lib.mkIf config.desktop.enable {
    user.homePackages = [
      nordic
    ];

    user.homeConfig = {
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
          sessionRestore.restoreOpenApplicationsOnLogin = "onLastLogout";
        };

        workspace = {
          clickItemTo = "select";
          lookAndFeel = "Nordic-bluish";
        };

        panels = [
          ./panels/dock.nix
          ./panels/topbar.nix
        ];
      };
    };
  };
}
