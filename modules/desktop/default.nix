{ config, lib, pkgs, ... }:
let
  cfg = config.desktop;
in
{
  imports = [
    ./plasma
    ./hyprland
    ./firefox.nix
  ];

  options = {
    desktop = {
      enable = lib.mkEnableOption "Desktop";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # Enable CUPS to print documents.
    services.printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };

    # Enable scanners
    hardware.sane = let
      # Override epkowa to use only the firmware for Epson Perfection V19
      epkowaV19 = pkgs.epkowa.override {
        plugins = { inherit (pkgs.epkowa.plugins) s650; };
      };
    in {
      enable = true;
      extraBackends = [ epkowaV19 ];
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
      extraConfig.pipewire."99-buffer" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 512;
        };
      };
    };

    user.homePackages = with pkgs; [
      blender
      inkscape
      obsidian
      pinta
      spotify
    ];
  };
}
