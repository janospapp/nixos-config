{ config, lib, pkgs, ... }:
let
  cfg = config.desktop.niri;
in
{
  imports = [
  ];

  options = {
    desktop.niri = {
      enable = lib.mkEnableOption "Niri";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;
  };
}

