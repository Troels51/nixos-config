{ config, pkgs, ... }:

{
  users.users.troels= {
    shell = pkgs.nushell;
  };
  environment.systemPackages = [
    pkgs.starship
    pkgs.carapace
  ];
}
