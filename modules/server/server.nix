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
    # Open ports for services that don't open it automatically
    #    80 - nginx, recerse proxy
    #  2049 - NFS
    allowedTCPPorts = [ 80 111 2049 ];
    allowedUDPPorts = [ 111 2049 ];
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

    nfs.server = {
      enable = true;
      exports = ''
        /export 192.168.50.0/24(rw,fsid=0,no_subtree_check)
        /export/data1 192.168.50.0/24(rw,nohide,insecure,no_subtree_check)
        /export/data2 192.168.50.0/24(rw,nohide,insecure,no_subtree_check)
        /export/service_data 192.168.50.0/24(rw,nohide,insecure,no_subtree_check)
      '';
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
