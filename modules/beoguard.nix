{ config, pkgs, ... }:
{

  age.secrets."beoguard-key" = {
    file = secrets/beoguard-key.age;
    mode = "640";
    owner = "systemd-network";
    group = "systemd-network";
  };

  networking.firewall.enable = false;
  services.resolved.enable = true;
  networking.useNetworkd = true;

  systemd.network = {
    enable = true;

    networks."50-wg0" = {
      matchConfig.Name = "wg0";

      address = [
        # /32 and /128 specifies a single address
        # for use on this wg peer machine
        "10.251.222.115/32"
      ];
      routes = [
                  {
                    routeConfig = {
                      Destination = "10.251.0.0/16";
                    };
                  }
               ];
      dns = ["10.251.222.1"];
    };

    netdevs."50-wg0" = {
      netdevConfig = {
        Kind = "wireguard";
        Name = "wg0";
      };

      wireguardConfig = {
        PrivateKeyFile = config.age.secrets.beoguard-key.path;
      };
      wireguardPeers = [
        {
          PublicKey = "svHWZVGliXo+NBtgc310lPu32AEUJMI++A3HTTYC/iQ=";
          AllowedIPs = [
            "10.251.0.0/16"
          ];
          Endpoint = "wg.development.bang-olufsen.com:51820";
          PersistentKeepalive = 20;
        }
      ];
    };
  };

}
