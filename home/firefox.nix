{ config, pkgs, ... }:

let
  theme = import ./theme.nix;
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
      userChrome = ''
        /* Her Theme userChrome.css */
        :root {
          --toolbar-bgcolor: ${theme.bg} !important;
          --toolbar-color: ${theme.fg} !important;
          --lwt-accent-color: ${theme.bg} !important;
          --lwt-text-color: ${theme.fg} !important;
          --tab-selected-bgcolor: ${theme.accent} !important;
          --tab-selected-textcolor: ${theme.bg} !important;
          --toolbarbutton-icon-fill: ${theme.peach} !important;
          --urlbar-box-bgcolor: ${theme.bg_alt} !important;
          --urlbar-box-text-color: ${theme.fg} !important;
          --urlbar-background-color: ${theme.bg_alt} !important;
        }

        #navigator-toolbox {
          background-color: var(--toolbar-bgcolor) !important;
          color: var(--toolbar-color) !important;
          border-bottom: 1px solid ${theme.muted} !important;
        }

        #urlbar-background {
          background-color: var(--urlbar-background-color) !important;
          border: 1px solid ${theme.muted} !important;
        }

        .tab-background[selected="true"] {
          background-color: var(--tab-selected-bgcolor) !important;
        }
        .tabbrowser-tab[selected="true"] .tab-text {
          color: var(--tab-selected-textcolor) !important;
        }
      '';
    };
  };
}
