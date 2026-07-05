{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.niri = {
    enable = true;
  };

  services.hypridle.enable = true;
  services.udisks2.enable = true;
  programs.hyprlock.enable = true;


  services.displayManager.sddm = {
     enable = true;
     wayland.enable = true;
  };


  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.fira-code
  ];

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
     pkgs.hyprlock
     pkgs.kitty
     pkgs.rofi
     pkgs.wallust
     pkgs.wlogout
     pkgs.nwg-look
     pkgs.nwg-displays
     pkgs.wezterm
     pkgs.wlogout
     pkgs.impala
     pkgs.dunst
     pkgs.waybar
     pkgs.zed-editor
     pkgs.rose-pine-cursor
     pkgs.bibata-cursors
     pkgs.glib # For gsettings
     pkgs.yad
     libsForQt5.qtstyleplugin-kvantum
     swww
     hyprpolkitagent
     xdg-desktop-portal-gtk
     thunar
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
