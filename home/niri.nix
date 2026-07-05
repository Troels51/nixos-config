{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  xdg.configFile = {
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
          gaps 8
          center-focused-column "never"

          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }

          default-column-width { proportion 0.5; }

          focus-ring {
              width 2
              active-color "${theme.accent}"
              inactive-color "${theme.muted}"
          }

          border {
              width 1
              active-color "${theme.accent}"
              inactive-color "${theme.muted}"
          }
      }

      prefer-no-csd

      window-rule {
          geometry-corner-radius 10
          clip-to-geometry true
          draw-border-with-background false
      }
      window-rule {
          match app-id="dev.zed.Zed"
          tiled-state false
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
          XF86PowerOff { spawn "sh" "-c" "CURRENT=$(cat /sys/firmware/acpi/platform_profile); if [ \"$CURRENT\" = \"low-power\" ]; then NEXT=\"balanced\"; elif [ \"$CURRENT\" = \"balanced\" ]; then NEXT=\"performance\"; else NEXT=\"power-saver\"; fi; sudo /run/current-system/sw/bin/tlp $NEXT; notify-send 'Power Profile' \"$NEXT\""; }

          // Session actions
          Mod+Shift+E { quit; }
      }
    '';

  };
}
