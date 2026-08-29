{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop.niri;
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    user.homePrograms.noctalia = {
      enable = true;

      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
          builtin = "Nord";
        };
      };
    };

    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    user.homePackages = [
      pkgs.gpu-screen-recorder # Needed for the screen recorder plugin
    ];
  };
}
