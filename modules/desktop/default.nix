{ config, lib, pkgs, inputs, system, ... }:
let
  cfg = config.desktop;
in
{
  imports = [
    ./plasma.nix
    ./firefox.nix
  ];

  options = {
    desktop = {
      enable = lib.mkEnableOption "Desktop";
      dockLaunchers = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [];
        description = "The list of applications to show on the bottom dock.";
        example = [
          applications:systemsettings.desktop
          applications:spotify.desktop
          applications:kitty.desktop
          preferred://browser
        ];
      };
    };
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
      obsidian
      pinta
      spotify
    ];
  };
}
