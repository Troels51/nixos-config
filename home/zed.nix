{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  xdg.configFile = {
    "zed/settings.json".text = ''
      {
        "theme": "Her",
        "ui_font_size": 16,
        "buffer_font_size": 14,
        "buffer_font_family": "Fira Code Nerd Font",
        "gutter": {
          "folds": false,
          "runnables": false,
          "min_line_number_digits": 2
        }
      }
    '';

    # Zed Theme
    "zed/themes/her.json".text = ''
      {
        "$schema": "https://zed.dev/schema/themes/v0.1.0.json",
        "name": "Her",
        "author": "Troels",
        "themes": [
          {
            "name": "Her",
            "appearance": "${theme.zedAppearance}",
            "style": {
              "background": "${theme.muted}",
              "background.appearance": "transparent",
              "title_bar.background": "${theme.accent}",
              "title_bar.inactive_background": "${theme.accent}",
              "editor.background": "${theme.bg}",
              "editor.foreground": "${theme.fg}",
              "editor.gutter.background": "${theme.muted}",
              "editor.line_number": "${theme.fg}",
              "editor.active_line_number": "${theme.peach}",
              "editor.selection.background": "${theme.selection_bg}",
              "editor.cursor": "${theme.accent}",
              "terminal.background": "${theme.bg}",
              "terminal.foreground": "${theme.fg}",
              "terminal.ansi.black": "${theme.ansi.black}",
              "terminal.ansi.red": "${theme.ansi.red}",
              "terminal.ansi.green": "${theme.ansi.green}",
              "terminal.ansi.yellow": "${theme.ansi.yellow}",
              "terminal.ansi.blue": "${theme.ansi.blue}",
              "terminal.ansi.magenta": "${theme.ansi.magenta}",
              "terminal.ansi.cyan": "${theme.ansi.cyan}",
              "terminal.ansi.white": "${theme.ansi.white}",
              "terminal.ansi.bright_black": "${theme.brights.black}",
              "terminal.ansi.bright_red": "${theme.brights.red}",
              "terminal.ansi.bright_green": "${theme.brights.green}",
              "terminal.ansi.bright_yellow": "${theme.brights.yellow}",
              "terminal.ansi.bright_blue": "${theme.brights.blue}",
              "terminal.ansi.bright_magenta": "${theme.brights.magenta}",
              "terminal.ansi.bright_cyan": "${theme.brights.cyan}",
              "terminal.ansi.bright_white": "${theme.brights.white}",
              "tab_bar.background": "${theme.muted}",
              "tab.inactive_background": "${theme.muted}",
              "tab.active_background": "${theme.bg_alt}",
              "tab.active_foreground": "${theme.peach}",
              "toolbar.background": "${theme.muted}",
              "panel.background": "${theme.muted}",
              "panel.focused_border": "${theme.peach}",
              "border": "${theme.muted}",
              "status_bar.background": "${theme.accent}"
            }
          }
        ]
      }
    '';

  };
}
