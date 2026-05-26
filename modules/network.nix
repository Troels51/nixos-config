{ config, pkgs, ... }:

{
  networking.hostName = "twix";
  networking.networkmanager.enable = false;
  networking.wireless.iwd.enable = true;

  networking.wireless.iwd.settings = {
    Network = {
      EnableIPv6 = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };
}
