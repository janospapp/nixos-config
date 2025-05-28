{ config, lib, pkgs, inputs, system, ... }:
let
  cfg = config.desktop;
in
{
  imports = [
    ./plasma.nix
  ];

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
      obsidian
      pinta
      spotify
    ];

    user.homeConfig = {
      firefox = {
        enable = true;
        profiles.${config.user.username} = {
          extensions.packages = with inputs.firefox-addons.packages.${system}; [
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
    };
  };
}
