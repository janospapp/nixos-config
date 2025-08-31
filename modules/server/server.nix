{ pkgs, inputs, modulesPath, ... }:
let
  sshKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEHWVUa8djH3H92jXHORARIf+2oFmotT2/TXYVEccK9"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE1yosmssktc9HzpCGkU+T3to6fwrxOyz7a9zJR0z6eZ"
  ];
in
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    inputs.nixarr.nixosModules.default
  ];

  networking.firewall = {
    allowedTCPPorts = [ 80 ];
  };

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
      stateDir = "/data/.state/gitea/";
      settings.server.HTTP_PORT = 9002;
    };

    qbittorrent = {
      enable = true;
      openFirewall = true;
      group = "media";
      profileDir = "/data/.state/qbittorrent/";
      webuiPort = 8085;
    };
  };

  users.users.janos.openssh.authorizedKeys.keys = sshKeys;
  users.users.root.openssh.authorizedKeys.keys = sshKeys;
}
