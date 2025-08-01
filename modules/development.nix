{ config, lib, pkgs, pkgs-unstable, ... }:
let
  cfg = config.development;
in {
  options.development = {
    enable = lib.mkEnableOption "development";
  };

  config = lib.mkIf cfg.enable {
    user.homePackages = with pkgs; [
      (ruby.withPackages (
        ps: with ps; [
          # Packages for LSP and linting in vim
          solargraph
          standard
        ]
      ))
      pkgs-unstable.claude-code
    ];

    user.homePrograms = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
