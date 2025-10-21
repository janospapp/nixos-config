{ config, lib, pkgs, inputs, system, ... }:
let
  cfg = config.desktop;
in
{
  imports = [
    ./plasma
    ./firefox.nix
  ];

  options = {
    desktop = {
      enable = lib.mkEnableOption "Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;

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

    # Needed for pipewire to acquire realtime priority of certain processes
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
