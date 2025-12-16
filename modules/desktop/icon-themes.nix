{ config, lib, pkgs, ... }:
let
  # Install only the `nord` variant of the theme
  tela-nord-icons = pkgs.tela-icon-theme.overrideAttrs (old: {
    dontCheckForBrokenSymlinks = true;
    installPhase = ''
      runHook preInstall

      patchShebangs install.sh
      mkdir -p $out/share/icons
      ./install.sh -d $out/share/icons nord

      runHook postInstall
    '';
  });
in
{
  config = lib.mkIf config.desktop.enable {
    user.homePackages = [
      tela-nord-icons
    ];
  };
}
