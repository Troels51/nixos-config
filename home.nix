{ config, pkgs, ... }:

{
  home.username = "troels";
  home.homeDirectory = "/home/troels";
  home.stateVersion = "25.11";
  home.enableNixpkgsReleaseCheck = false;

  # Install essential custom package tools for Wayland, Niri, etc.
  home.packages = with pkgs; [
    swaybg
    brightnessctl
    wl-clipboard
    grim
    slurp
    font-awesome
    nerd-fonts.fira-code
  ];

  # Configure Wezterm
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require 'wezterm'
      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- Typography
      config.font = wezterm.font("Fira Code Nerd Font")
      config.font_size = 11.5

      -- Aesthetics
      config.window_background_opacity = 0.95
      config.window_decorations = "NONE"
      config.window_padding = {
        left = 14,
        right = 14,
        top = 14,
        bottom = 14,
      }

      -- Her Color Scheme (Warm Retro Cocoa & Sunset Orange)
      config.colors = {
        background = "#1c1514",
        foreground = "#f5ebd6",
        cursor_bg = "#d94625",
        cursor_fg = "#1c1514",
        cursor_border = "#d94625",
        selection_bg = "#423432",
        selection_fg = "#f5ebd6",

        ansi = {
          "#1c1514", -- black
          "#d94625", -- red (Her orange-red)
          "#a2b997", -- green (warm sage)
          "#ffd3b6", -- yellow (warm peach)
          "#e07a5f", -- blue (sunset orange-blue)
          "#f4a261", -- magenta (warm amber)
          "#8ecae6", -- cyan (soft sky)
          "#f5ebd6", -- white
        },
        brights = {
          "#423432", -- black
          "#ff5733", -- red
          "#b7d1a5", -- green
          "#ffebd3", -- yellow
          "#f28f79", -- blue
          "#ffb703", -- magenta
          "#a8dadc", -- cyan
          "#fafaf9", -- white
        }
      }

      return config
    '';
  };

  # Configure Waybar
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 36;
      margin-top = 8;
      margin-left = 8;
      margin-right = 8;
      modules-left = [ "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "pulseaudio" "battery" ];

      "niri/workspaces" = {
        format = "{name}";
        active-only = false;
      };

      "clock" = {
        format = "{:%H:%M  |  %a, %b %d}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "network" = {
        format-wifi = "   {essid}";
        format-ethernet = "󰈀   {ifname}";
        format-disconnected = "󰖪   Disconnected";
        tooltip-format = "{ifname} via {gwaddr}";
      };

      "pulseaudio" = {
        format = "{icon}   {volume}%";
        format-muted = "󰝟   Muted";
        format-icons = {
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon}   {capacity}%";
        format-charging = "󱐋 {capacity}%";
        format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
      };
    }];
    style = ''
      /* Waybar Custom CSS - Her Movie Theme */
      * {
        font-family: "Fira Code Nerd Font", "sans-serif";
        font-size: 13px;
        font-weight: 500;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(28, 21, 20, 0.85);
        color: #f5ebd6;
        border-radius: 12px;
        transition-property: background-color;
        transition-duration: .5s;
        border: 1px solid rgba(217, 70, 37, 0.2);
      }

      /* Workspaces */
      #workspaces {
        margin: 4px;
        padding: 0 4px;
      }

      #workspaces button {
        padding: 0 10px;
        color: #f5ebd6;
        background-color: transparent;
        border-radius: 8px;
        margin: 0 2px;
        transition: all 0.3s ease;
      }

      #workspaces button.focused {
        color: #1c1514;
        background-color: #d94625;
        font-weight: bold;
      }

      #workspaces button.active {
        color: #1c1514;
        background-color: #d94625;
        font-weight: bold;
      }

      #workspaces button:hover {
        background-color: rgba(242, 143, 121, 0.2);
      }

      /* Window Title */
      #window {
        padding: 0 15px;
        color: #f28f79;
        font-style: italic;
      }

      /* Modules styling */
      #clock,
      #network,
      #pulseaudio,
      #battery {
        padding: 0 15px;
        margin: 4px;
        border-radius: 8px;
        background-color: rgba(66, 52, 50, 0.4);
        color: #f5ebd6;
      }

      #clock {
        background-color: transparent;
        color: #f5ebd6;
        font-weight: bold;
        font-size: 14px;
      }

      #network {
        color: #ffd3b6;
      }

      #pulseaudio {
        color: #e07a5f;
      }

      #battery {
        color: #a2b997;
      }

      #battery.charging {
        color: #ffd3b6;
        background-color: rgba(217, 70, 37, 0.2);
      }

      #battery.warning:not(.charging) {
        color: #d94625;
        background-color: rgba(217, 70, 37, 0.1);
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: rgba(217, 70, 37, 0.3);
          color: #fafaf9;
        }
      }
    '';
  };

  # Configure Rofi
  programs.rofi = {
    enable = true;
  };

  # Custom configuration files written directly to ~/.config
  xdg.configFile = {
    # Niri Config
    "niri/config.kdl".text = ''
      // Niri Configuration file - Her Movie Theme

      input {
          keyboard {
              xkb {
                  layout "us"
              }
          }
          touchpad {
              tap
              natural-scroll
          }
          mouse {
              natural-scroll
          }
      }

      layout {
          gaps 12
          center-focused-column "never"

          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }

          default-column-width { proportion 0.5; }

          focus-ring {
              width 2
              active-color "#d94625"
              inactive-color "#423432"
          }
      }

      // Startup applications
      spawn-at-startup "sh" "-c" "swaybg -i /home/troels/nixos-config/her_wallpaper.jpg -m fill"
      spawn-at-startup "waybar"
      spawn-at-startup "dunst"
      spawn-at-startup "hypridle"

      binds {
          // Terminal and Launcher
          Mod+Return { spawn "wezterm"; }
          Mod+D { spawn "rofi" "-show" "drun"; }
          Mod+Space { spawn "rofi" "-show" "drun"; }
          Mod+C { close-window; }
          Mod+Q { close-window; }

          // Navigation (Vim keys)
          Mod+H     { focus-column-left; }
          Mod+J     { focus-window-down; }
          Mod+K     { focus-window-up; }
          Mod+L     { focus-column-right; }
          
          // Navigation (Arrow keys)
          Mod+Left  { focus-column-left; }
          Mod+Down  { focus-window-down; }
          Mod+Up    { focus-window-up; }
          Mod+Right { focus-column-right; }

          // Move columns/windows (Vim keys)
          Mod+Shift+H     { move-column-left; }
          Mod+Shift+J     { move-window-down; }
          Mod+Shift+K     { move-window-up; }
          Mod+Shift+L     { move-column-right; }
          
          // Move columns/windows (Arrow keys)
          Mod+Shift+Left  { move-column-left; }
          Mod+Shift+Down  { move-window-down; }
          Mod+Shift+Up    { move-window-up; }
          Mod+Shift+Right { move-column-right; }

          // Workspace navigation
          Mod+Page_Down       { focus-workspace-down; }
          Mod+Page_Up         { focus-workspace-up; }
          Mod+U               { focus-workspace-down; }
          Mod+I               { focus-workspace-up; }
          Mod+Shift+Page_Down { move-column-to-workspace-down; }
          Mod+Shift+Page_Up   { move-column-to-workspace-up; }
          Mod+Shift+U         { move-column-to-workspace-down; }
          Mod+Shift+I         { move-column-to-workspace-up; }

          // Direct workspace access
          Mod+1 { focus-workspace 1; }
          Mod+2 { focus-workspace 2; }
          Mod+3 { focus-workspace 3; }
          Mod+4 { focus-workspace 4; }
          Mod+5 { focus-workspace 5; }
          Mod+6 { focus-workspace 6; }
          Mod+7 { focus-workspace 7; }
          Mod+8 { focus-workspace 8; }
          Mod+9 { focus-workspace 9; }

          Mod+Shift+1 { move-column-to-workspace 1; }
          Mod+Shift+2 { move-column-to-workspace 2; }
          Mod+Shift+3 { move-column-to-workspace 3; }
          Mod+Shift+4 { move-column-to-workspace 4; }
          Mod+Shift+5 { move-column-to-workspace 5; }
          Mod+Shift+6 { move-column-to-workspace 6; }
          Mod+Shift+7 { move-column-to-workspace 7; }
          Mod+Shift+8 { move-column-to-workspace 8; }
          Mod+Shift+9 { move-column-to-workspace 9; }

          // Layout adjustments
          Mod+R { switch-preset-column-width; }
          Mod+F { maximize-column; }
          Mod+Shift+F { fullscreen-window; }

          // Column stacking
          Mod+Comma  { consume-window-into-column; }
          Mod+Period { expel-window-from-column; }

          // Window sizing
          Mod+Minus { set-column-width "-10%"; }
          Mod+Equal { set-column-width "+10%"; }
          Mod+Shift+Minus { set-window-height "-10%"; }
          Mod+Shift+Equal { set-window-height "+10%"; }

          // Media controls
          XF86AudioRaiseVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
          XF86AudioLowerVolume { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
          XF86AudioMute        { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          
          XF86MonBrightnessUp   { spawn "brightnessctl" "set" "10%+"; }
          XF86MonBrightnessDown { spawn "brightnessctl" "set" "10%-"; }

          // Session actions
          Mod+Shift+E { quit; }
      }
    '';

    # Rofi Custom Theme (config.rasi)
    "rofi/config.rasi".text = ''
      configuration {
          modi: "drun,run";
          font: "Fira Code Nerd Font 11";
          show-icons: true;
          drun-display-format: "{name}";
          display-drun: " ";
          display-run: " ";
      }

      @theme "/dev/null"

      * {
          bg: #1c1514;
          bg-alt: #2d211f;
          fg: #f5ebd6;
          accent: #d94625;
          peach: #f28f79;
          muted: #423432;

          background-color: transparent;
          text-color: @fg;
      }

      window {
          width: 500px;
          background-color: @bg;
          border: 2px solid @accent;
          border-radius: 12px;
          padding: 20px;
      }

      mainbox {
          children: [ inputbar, listview ];
          spacing: 15px;
      }

      inputbar {
          background-color: @bg-alt;
          border-radius: 8px;
          padding: 10px;
          children: [ prompt, entry ];
      }

      prompt {
          text-color: @peach;
          margin: 0px 8px 0px 0px;
      }

      entry {
          placeholder: "Search applications...";
          placeholder-color: @muted;
      }

      listview {
          columns: 1;
          lines: 6;
          fixed-height: true;
          spacing: 5px;
      }

      element {
          padding: 8px;
          border-radius: 6px;
          orientation: horizontal;
      }

      element selected {
          background-color: @accent;
          text-color: @bg;
      }

      element-icon {
          size: 24px;
          margin: 0px 10px 0px 0px;
      }

      element-text {
          vertical-align: 0.5;
          text-color: inherit;
      }
    '';
  };
}
