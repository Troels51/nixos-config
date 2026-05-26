{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user.name  = "Troels Dalsgaard Hoffmeyer";
      user.email = "tdah@bang-olufsen.dk";

      init.defaultBranch = "main";
    };
  };

  environment.systemPackages = with pkgs; [
    gh
    lazygit
  ];
}
