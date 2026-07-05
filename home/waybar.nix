{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 36;
      margin-top = 8;
      margin-left = 8;
      margin-right = 8;
      margin-bottom = 8;
      modules-left = [  "niri/workspaces" "niri/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "network" "pulseaudio" "custom/battery" "custom/powermenu"];

      "custom/powermenu" = {
        format = "";
        on-click = "sh -c 'chosen=$(printf \"  Power Off\\n  Reboot\\n  Suspend\\n  Log Out\" | rofi -dmenu -i -p \"Session\"); case \"$chosen\" in \"  Power Off\") systemctl poweroff ;; \"  Reboot\") systemctl reboot ;; \"  Suspend\") systemctl suspend ;; \"  Log Out\") niri msg action quit ;; esac'";
        tooltip = false;
      };

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
        on-click = "wezterm start -- impala";
      };

      "pulseaudio" = {
        format = "{icon}   {volume}%";
        format-muted = "󰝟   Muted";
        format-icons = {
          default = [ "󰕿" "󰖀" "󰕾" ];
        };
        on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      "custom/battery" = {
        exec = ''
          sh -c '
            BATT=$(cat /sys/class/power_supply/BAT0/capacity)
            STATUS=$(cat /sys/class/power_supply/BAT0/status)
            PROF=$(cat /sys/firmware/acpi/platform_profile)
            if [ "$PROF" = "performance" ]; then ICON=""; elif [ "$PROF" = "balanced" ]; then ICON=""; else ICON=""; fi
            TEXT="$ICON   $BATT%"
            if [ "$STATUS" = "Charging" ]; then TEXT="󱐋 $TEXT"; fi
            CLASS=""
            if [ "$STATUS" = "Charging" ]; then CLASS="charging"; elif [ "$BATT" -le 15 ]; then CLASS="critical warning"; elif [ "$BATT" -le 30 ]; then CLASS="warning"; fi
            printf "{\"text\": \"%s\", \"class\": \"%s\", \"tooltip\": \"Battery: %s%% (%s)\\\\nProfile: %s\"}\n" "$TEXT" "$CLASS" "$BATT" "$STATUS" "$PROF"
          '
        '';
        return-type = "json";
        interval = 5;
        on-click = "sh -c 'CURRENT=$(cat /sys/firmware/acpi/platform_profile); if [ \"$CURRENT\" = \"low-power\" ]; then NEXT=\"balanced\"; elif [ \"$CURRENT\" = \"balanced\" ]; then NEXT=\"performance\"; else NEXT=\"power-saver\"; fi; sudo /run/current-system/sw/bin/tlp $NEXT; notify-send \"Power Profile\" \"$NEXT\"'";
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
        background-color: ${theme.bg_rgba_85};
        color: ${theme.fg};
        border-radius: 12px;
        transition-property: background-color;
        transition-duration: .5s;
        border: 1px solid ${theme.accent_rgba_20};
      }

      /* Workspaces */
      #workspaces {
        margin: 4px;
        padding: 0 4px;
        background-color: ${theme.accent_rgba_20};
        border-radius: 8px;
      }

      #workspaces button {
        padding: 0 10px;
        color: ${theme.fg};
        background-color: transparent;
        border-radius: 8px;
        margin: 0 2px;
        transition: all 0.3s ease;
      }

      #workspaces button.focused {
        color: ${theme.bg};
        background-color: ${theme.accent};
        font-weight: bold;
      }

      #workspaces button.active {
        color: ${theme.bg};
        background-color: ${theme.accent};
        font-weight: bold;
      }

      #workspaces button:hover {
        background-color: ${theme.peach_rgba_20};
      }

      /* Window Title */
      #window {
        padding: 0 15px;
        color: ${theme.peach};
        font-style: italic;
      }

      /* Modules styling */
      #custom-powermenu,
      #custom-battery,
      #clock,
      #network,
      #pulseaudio {
        padding: 0 15px;
        margin: 4px;
        border-radius: 8px;
        background-color: ${theme.accent_rgba_20};
        color: ${theme.fg};
      }

      #custom-powermenu:hover,
      #custom-battery:hover,
      #network:hover,
      #pulseaudio:hover {
        background-color: ${theme.accent_rgba_40};
      }

      #custom-powermenu {
        color: ${theme.ansi.red};
      }

      #clock {
        background-color: transparent;
        color: ${theme.fg};
        font-weight: bold;
        font-size: 14px;
      }

      #network {
        color: ${theme.ansi.yellow};
      }

      #pulseaudio {
        color: ${theme.ansi.blue};
      }

      #custom-battery {
        color: ${theme.ansi.green};
      }

      #custom-battery.charging {
        color: ${theme.ansi.yellow};
        background-color: ${theme.accent_rgba_20};
      }

      #custom-battery.warning:not(.charging) {
        color: ${theme.accent};
        background-color: ${theme.accent_rgba_10};
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      @keyframes blink {
        to {
          background-color: ${theme.accent_rgba_30};
          color: ${theme.brights.white};
        }
      }
    '';
  };
}
