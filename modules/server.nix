{ pkgs, inputs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixarr.nixosModules.default
  ];

  nixarr = {
    enable = true;

    bazarr.enable = true;
    jellyfin.enable = true;
    jellyseerr.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        X11Forwarding = false;
        PermitRootLogin = "prohibit-password";
      };
    };

    gitea = {
      enable = true;
    };

    qbittorrent = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
  };

  users.users.janos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEHWVUa8djH3H92jXHORARIf+2oFmotT2/TXYVEccK9"
  ];
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEHWVUa8djH3H92jXHORARIf+2oFmotT2/TXYVEccK9"
  ];
}
