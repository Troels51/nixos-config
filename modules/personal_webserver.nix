{ config, pkgs, ... }:
{
  users.groups.www = {};

  systemd.tmpfiles.rules = [
    "d /var/www 0775 caddy www"
  ];

  age.secrets."caddy_env" = {
    file = secrets/hetzner_api_key.age;
    mode = "640";
    owner = "caddy";
    group = "caddy";
  };
  systemd.services.caddy.serviceConfig.EnvironmentFile = [config.age.secrets.caddy_env.path];

  services.caddy = {
    enable = true;
    group = "www";

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/hetzner/v2@v2.0.1" ];
      hash = "sha256-Y1FYfyJC7vAKbSEyX7n0GuxeXxcx+1NWr1HrqXKt7io=";
    };

    extraConfig = ''
      https://hffmr.dk {
        tls {
                dns hetzner {env.HETZNER_TOKEN}
        }
        encode zstd gzip
        root * /var/www/hffmr.dk
        file_server
      }
    '';
  };
}
