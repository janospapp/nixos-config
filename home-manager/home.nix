{ inputs, outputs, system, pkgs, username, ... }:
{
  home = let
    localPackages = with outputs.packages.${system}; [
      plasma-panel-templates
    ];
  in {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.11";
    packages = with pkgs; [
      devenv
      inkscape
      nordic
      obsidian
      papirus-icon-theme
      pinta
      slack
      spotify
      teams-for-linux
    ] ++ localPackages;
  };

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    firefox = {
      enable = true;
      profiles.${username} = {
        extensions = with inputs.firefox-addons.packages.${system}; [
          bitwarden
          plasma-integration
          ublock-origin
        ];

        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "widget.use-xdg-desktop-portal.mime-handler" = 1;
        };
      };
    };

    git = import ./core/git.nix;
    kitty = import ./core/kitty.nix;

    plasma = {
      enable = true;
      workspace.clickItemTo = "select";

      configFile = {
        kdeglobals = {
          Icons.Theme = "Papirus-Dark";
          KDE.LookAndFeelPackage = "Nordic-bluish";
        };
      };
    };

    tmux = import ./core/tmux.nix;
    vim = import ./core/vim.nix pkgs;
    zsh = import ./core/zsh pkgs;
  };

  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
    };
  };
}
