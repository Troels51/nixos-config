{ config, pkgs, ... }:

{
  imports = [
    ./home/wezterm.nix
    ./home/waybar.nix
    ./home/rofi.nix
    # ./home/zed.nix
    ./home/niri.nix
  ];

  home.username = "troels";
  home.homeDirectory = "/home/troels";
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;

  # Cursor theme - warm amber to match the Her terracotta accent
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Amber";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Install essential custom package tools for Wayland, Niri, etc.
  home.packages = with pkgs; [
    swaybg
    brightnessctl
    wl-clipboard
    grim
    slurp
    font-awesome
    nerd-fonts.fira-code
    zed-editor
  ];

}
