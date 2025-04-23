{ config, lib, pkgs, ... }:
let
  cfg = config.workTools;
in {
  options.workTools = {
    enable = lib.mkEnableOption "workTools";
  };

  config = lib.mkIf cfg.enable {
    development.enable = lib.mkForce true;
    user.homePackages = with pkgs; [
      awscli2
      kubectl
      kubectx
      postman
      slack
      teams-for-linux
    ];
  };
}
