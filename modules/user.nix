{ config, lib, pkgs, ... }:
let
  cfg = config.user;
in {
  options.user = {
    username = lib.mkOption {
      type = lib.types.str;
      example = "johndoe";
      description = "The username of the main user in the system.";
    };

    name = lib.mkOption {
      type = lib.types.str;
      example = "John Doe";
      description = "The name of the main user in the system.";
    };

    email = lib.mkOption {
      type = lib.types.str;
      example = "johndoe@example.com";
      description = "The email address of the main user in the system.";
    };

    uid = lib.mkOption {
      type = lib.types.number;
      default = 1000;
      example = "1003";
      description = "The user's UID. 1000 by default.";
    };

    timeZone = lib.mkOption {
      type = lib.types.str;
      example = "Europe/London";
      description = "The system time zone for the user.";
    };

    homePackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      example = "with pkgs; [slack spotify]";
      default = [];
      description = "What packages to install in the user space through Home Manager.";
    };

    homePrograms = lib.mkOption {
      type = lib.types.attrs;
      description = "The user's Home Manager program configurations.";
    };

    homeFiles = lib.mkOption {
      type = lib.types.attrs;
      description = "What user files to create with Home Manager";
      example = ''
        {
          ".local/bin/test.sh" = {
            text = "echo Hello World";
          };
        }
      '';
    };

    homeXdg = lib.mkOption {
      type = lib.types.attrs;
      description = "The user's Home Manager XDG configuration.";
    };
  };

  config = {
    users.users.${cfg.username} = {
      isNormalUser = true;
      initialPassword = "P@ssw0rd"; # Define a user account. Don't forget to set a password with ‘passwd’.
      extraGroups = [ "input" "kvm" "networkmanager" "scanner" "wheel" ];
      shell = pkgs.zsh;
      uid = cfg.uid;
    };

    home-manager.users.${cfg.username} = {
      fonts.fontconfig.enable = true;

      home = {
        username = cfg.username;
        homeDirectory = "/home/${cfg.username}";

        stateVersion = config.system.stateVersion;
        packages = with pkgs; [
          nerd-fonts.noto
          nerd-fonts.symbols-only
        ] ++ cfg.homePackages;

        file = cfg.homeFiles;
      };

      programs = {
        home-manager.enable = true;
      } // cfg.homePrograms;

      services = {
        syncthing = {
          enable = true;
          tray.enable = true;
        };
      };

      xdg = cfg.homeXdg;

      stylix.targets.firefox.profileNames = [ cfg.username ];
    };

    stylix = {
      enable = true;
      polarity = "dark";
      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    };
  };
}
