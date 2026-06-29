{ config, pkgs, ... }:
{
  users.groups.www = {};

  systemd.tmpfiles.rules = [
    "d /var/www 0775 caddy www"
  ];

  services.caddy = {
    enable = true;
    group = "www";

    extraConfig = ''
      http://hffmr.dk {
        encode zstd gzip
        root * /var/www/hffmr.dk
        file_server
      }
    '';
  };
}
