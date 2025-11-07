{ config, lib, pkgs-unstable, ... }:
let
  cfg = config.desktop.hyprland;
in
{
  imports = [
    ./hyprland.nix
    ./hyprpanel.nix
    ./screenshot.nix
  ];

  options = {
    desktop.hyprland = {
      enable = lib.mkEnableOption "Hyprland";
    };
  };

  config = lib.mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
        package = pkgs-unstable.hyprland;
      };
      hyprlock = {
        enable = true;
        package = pkgs-unstable.hyprlock;
      };
    };
    environment.systemPackages = with pkgs-unstable; [
      hyprland-protocols
      rofi
      wl-clipboard
    ];
  };
}
