{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop;
in
{
  options = {
    desktop.enable = lib.mkEnableOption "Desktop";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.xserver.desktopManager.plasma5.enable = true;

    # Enable scanners
    hardware.sane = {
      enable = true;
      extraBackends = [ pkgs.epkowa ];
    };

    environment.systemPackages = with pkgs; [
      libreoffice
      simple-scan
    ];

    # Enable sound.
    # sound.enable = true;
    # hardware.pulseaudio.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
