{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.rofi = {
    enable = true;
  };

  xdg.configFile = {
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
          bg: ${theme.bg};
          bg-alt: ${theme.bg_alt};
          fg: ${theme.fg};
          accent: ${theme.accent};
          peach: ${theme.peach};
          muted: ${theme.muted};

          background-color: transparent;
          text-color: @fg;
      }

      window {
          width: 500px;
          background-color: @bg;
          border: 2px;
          border-color: @accent;
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
