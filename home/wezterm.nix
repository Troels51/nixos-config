{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
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
      config.use_fancy_tab_bar = true
      config.window_frame = {
        active_titlebar_bg = "${theme.bg_alt}",
        inactive_titlebar_bg = "${theme.bg_alt}",
      }
      config.window_padding = {
        left = 14,
        right = 14,
        top = 14,
        bottom = 14,
      }

      -- Her Color Scheme
      config.colors = {
        background = "${theme.bg}",
        foreground = "${theme.fg}",
        cursor_bg = "${theme.accent}",
        cursor_fg = "${theme.cursor_fg}",
        cursor_border = "${theme.accent}",
        selection_bg = "${theme.selection_bg}",
        selection_fg = "${theme.selection_fg}",
        tab_bar = {
          background = "${theme.bg_alt}",
          inactive_tab_edge = "${theme.muted}",
          active_tab = {
            bg_color = "${theme.accent}",
            fg_color = "${theme.bg}",
          },
          inactive_tab = {
            bg_color = "${theme.bg}",
            fg_color = "${theme.fg}",
          },
          inactive_tab_hover = {
            bg_color = "${theme.muted}",
            fg_color = "${theme.fg}",
          },
          new_tab = {
            bg_color = "${theme.bg}",
            fg_color = "${theme.fg}",
          },
          new_tab_hover = {
            bg_color = "${theme.muted}",
            fg_color = "${theme.fg}",
          },
        },

        ansi = {
          "${theme.ansi.black}",
          "${theme.ansi.red}",
          "${theme.ansi.green}",
          "${theme.ansi.yellow}",
          "${theme.ansi.blue}",
          "${theme.ansi.magenta}",
          "${theme.ansi.cyan}",
          "${theme.ansi.white}",
        },
        brights = {
          "${theme.brights.black}",
          "${theme.brights.red}",
          "${theme.brights.green}",
          "${theme.brights.yellow}",
          "${theme.brights.blue}",
          "${theme.brights.magenta}",
          "${theme.brights.cyan}",
          "${theme.brights.white}",
        }
      }

      return config
    '';
  };
}
