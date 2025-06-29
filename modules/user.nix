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

    homeXdg = lib.mkOption {
      type = lib.types.attrs;
      description = "The user's Home Manager XDG configuration.";
    };
  };

  config = {
    users.users.${cfg.username} = {
      isNormalUser = true;
      initialPassword = "P@ssw0rd"; # Define a user account. Don't forget to set a password with ‘passwd’.
      extraGroups = [ "wheel" "scanner" ];
      shell = pkgs.zsh;
    };

    home-manager.users.${cfg.username} = {
      home = {
        username = cfg.username;
        homeDirectory = "/home/${cfg.username}";

        stateVersion = config.system.stateVersion;
        packages = config.user.homePackages;
      };

      programs = {
        home-manager.enable = true;
      } // config.user.homePrograms;

      services = {
        syncthing = {
          enable = true;
          tray.enable = true;
        };
      };

      xdg = config.user.homeXdg;
    };
  };
}
