{ config, pkgs, inputs, modulesPath, ... }:
let
  localServices = [
      {
        name = "jellyfin";
        port = 8096;
      }
      {
        name = "gitea";
        port = config.services.gitea.settings.server.HTTP_PORT;
      }
  ] ++ map (name: {
    inherit name;
    port = config.services.${name}.settings.server.port;
  }) [ "sonarr" "radarr" "prowlarr" ];

  topDomain = "home2";
in
{
  services.nginx = {
    enable = true;
    enableReload = true;
    virtualHosts = {
      "qbittorrent.${topDomain}" = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString config.services.qbittorrent.webuiPort}";
          proxyWebsockets = true;
          extraConfig = ''
            proxy_set_header Host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;

            # Required for qBittorrent WebUI
            proxy_set_header Referer $http_referer;
            proxy_set_header Origin $http_origin;
          '';
        };
      };
    } // builtins.listToAttrs (map ({ name, port }: {
      name = "${name}.${topDomain}";
      value = {
        locations."/" = {
          proxyPass = "http://127.0.0.1:${toString port}";
        };
      };
    }) localServices);
  };
}
