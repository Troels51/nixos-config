{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.copilot-cli
  ];
}
