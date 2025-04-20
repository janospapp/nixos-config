{ config, lib, pkgs, ... }:
let
  cfg = config.development;
in {
  options.development = {
    enable = lib.mkEnableOption "workTools";
  };

  config = lib.mkIf cfg.enable {
    user.homePackages = with pkgs; [
      devenv
    ];

    user.homeConfig = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
