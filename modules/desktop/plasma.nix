{ config, lib, pkgs, ... }:
let
  nordic = pkgs.nordic.overrideAttrs (old: {
    # It converts the .desktop files to .json to be compatible with plasma 6
    srcs = [
      (pkgs.fetchFromGitHub {
        owner = "janospapp";
        repo = "nordic";
        rev = "a3f7242acd9b969b30213f93669ba47f2ebd9d5e";
        hash = "sha256-L3HW5Kq1dI9XZzwI3AKORsxCFiAOwGNLqBOJ1lF8XYQ=";
        name = "Nordic";
      })
    ];

    # I had to remove the deduplication, otherwise plasma didn't want to install
    # the theme, as the files were linked outside of the folder. This seems to
    # be a protection in plasma 6. With removing deduplication, I also removed the
    # theme files for other desktops (i.e. gnome, cinammon, xfce, ...)
    installPhase = ''
      runHook preInstall

      # install theme files
      mkdir -p $out/share/themes
      cp -a Nordic* $out/share/themes

      # remove uneeded files
      rm -r $out/share/themes/*/.gitignore
      rm -r $out/share/themes/*/Art
      rm -r $out/share/themes/*/FUNDING.yml
      rm -r $out/share/themes/*/LICENSE
      rm -r $out/share/themes/*/README.md
      rm -r $out/share/themes/*/{package.json,package-lock.json,Gulpfile.js}
      rm -r $out/share/themes/*/src
      rm -r $out/share/themes/*/cinnamon
      rm -r $out/share/themes/*/gnome-shell
      rm -r $out/share/themes/*/gtk-2.0
      rm -r $out/share/themes/*/gtk-3.0
      rm -r $out/share/themes/*/gtk-4.0
      rm -r $out/share/themes/*/xfwm4

      # move wallpapers to appropriate directory
      mkdir -p $out/share/wallpapers/Nordic
      mv -v $out/share/themes/Nordic/extras/wallpapers/* $out/share/wallpapers/Nordic/
      rmdir $out/share/themes/Nordic/extras{/wallpapers,}

      # move kde related contents to appropriate directories
      mkdir -p $out/share/{aurorae/themes,color-schemes,Kvantum,plasma,icons}
      mv -v $out/share/themes/Nordic/kde/aurorae/* $out/share/aurorae/themes/
      mv -v $out/share/themes/Nordic/kde/colorschemes/* $out/share/color-schemes/
      mv -v $out/share/themes/Nordic/kde/konsole $out/share/
      mv -v $out/share/themes/Nordic/kde/kvantum/* $out/share/Kvantum/
      cp -vr $out/share/themes/Nordic/kde/plasma/look-and-feel $out/share/plasma/look-and-feel/
      mv -v $out/share/themes/Nordic/kde/plasma/look-and-feel $out/share/plasma/desktoptheme/
      mv -v $out/share/themes/Nordic/kde/folders/* $out/share/icons/
      mv -v $out/share/themes/Nordic/kde/cursors/*-cursors $out/share/icons/

      rm -rf $out/share/plasma/look-and-feel/*/contents/{logout,osd,components}
      rm -rf $out/share/plasma/desktoptheme/*/contents/{{defaults,splash,previews}

      mkdir -p $sddm/share/sddm/themes
      mv -v $out/share/themes/Nordic/kde/sddm/* $sddm/share/sddm/themes/

      rm -rf $out/share/themes/Nordic/kde

      runHook postInstall
    '';
  });

  # Install only the `nord` variant of the theme
  tela-nord-icons = pkgs.tela-icon-theme.overrideAttrs (old: {
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
      nordic
      tela-nord-icons
      pkgs.kora-icon-theme
    ];

    user.homeConfig = {
      plasma = {
        enable = true;
        overrideConfig = true;

        input.keyboard = {
          layouts = [
            { layout = "us"; }
            { layout = "hu"; }
          ];
          numlockOnStartup = "on";
          options = [
            "caps:escape_shifted_capslock"
          ];
        };

        session = {
          sessionRestore.restoreOpenApplicationsOnLogin = "onLastLogout";
        };

        workspace = {
          clickItemTo = "select";
          lookAndFeel = "Nordic-bluish";
          iconTheme = "Tela-nord-dark";
        };

        panels = [
          ./panels/dock.nix
          ./panels/topbar.nix
        ];
      };
    };
  };
}
