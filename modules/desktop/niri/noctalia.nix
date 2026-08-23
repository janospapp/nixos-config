{ config, lib, pkgs, inputs, ... }:
{
  config = lib.mkIf config.desktop.niri.enable {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    user.homePrograms.noctalia = {
      enable = true;
    };

    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
  };
}
