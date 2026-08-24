{ config, lib, pkgs, inputs, ... }:
let
  cfg = config.desktop.niri;
in
{
  imports = [
    inputs.niri.nixosModules.niri
    ./niri.nix
    ./noctalia.nix
  ];

  options = {
    desktop.niri = {
      enable = lib.mkEnableOption "Niri";
    };
  };
}

