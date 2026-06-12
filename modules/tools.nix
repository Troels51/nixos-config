{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
     pkgs.kanban
     pkgs.github-copilot-cli
     pkgs.just
  ];

}
