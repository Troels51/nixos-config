let
  isDayMode = true; # Set to false for night mode

  in
if isDayMode then {
    name = "Day";
    bg = "#F9F6F0";
    bg_alt = "#EAD7CD";
    fg = "#4A3E3D";
    accent = "#E28766"; # Terracotta Pastel Orange
    peach = "#D37B73";  # Classic Her shirt color
    muted = "#EAD7CD";

    # Wezterm specifics
    cursor_fg = "#F9F6F0";
    selection_bg = "#EAD7CD";
    selection_fg = "#4A3E3D";

    ansi = {
      black = "#F9F6F0";
      red = "#D37B73";
      green = "#7a9c6b";
      yellow = "#E28766";
      blue = "#D37B73";
      magenta = "#c57545";
      cyan = "#5b98b5";
      white = "#4A3E3D";
    };
    brights = {
      black = "#EAD7CD";
      red = "#E28766";
      green = "#5e7c50";
      yellow = "#D37B73";
      blue = "#E28766";
      magenta = "#a65d33";
      cyan = "#427690";
      white = "#000000";
    };

    # RGBA values for Waybar
    bg_rgba_85 = "rgba(249, 246, 240, 0.85)";
    accent_rgba_20 = "rgba(226, 135, 102, 0.2)";
    accent_rgba_10 = "rgba(226, 135, 102, 0.1)";
    accent_rgba_30 = "rgba(226, 135, 102, 0.3)";
    accent_rgba_40 = "rgba(226, 135, 102, 0.4)";
    peach_rgba_20 = "rgba(211, 123, 115, 0.2)";
    muted_rgba_40 = "rgba(234, 215, 205, 0.4)";
    zedAppearance = "light";
  } else {
    name = "Night";
    bg = "#1c1514";
    bg_alt = "#2d211f";
    fg = "#f5ebd6";
    accent = "#d94625";
    peach = "#f28f79";
    muted = "#423432";

    # Wezterm specifics
    cursor_fg = "#1c1514";
    selection_bg = "#423432";
    selection_fg = "#f5ebd6";

    ansi = {
      black = "#1c1514";
      red = "#d94625";
      green = "#a2b997";
      yellow = "#ffd3b6";
      blue = "#e07a5f";
      magenta = "#f4a261";
      cyan = "#8ecae6";
      white = "#f5ebd6";
    };
    brights = {
      black = "#423432";
      red = "#ff5733";
      green = "#b7d1a5";
      yellow = "#ffebd3";
      blue = "#f28f79";
      magenta = "#ffb703";
      cyan = "#a8dadc";
      white = "#fafaf9";
    };

    # RGBA values for Waybar
    bg_rgba_85 = "rgba(28, 21, 20, 0.85)";
    accent_rgba_20 = "rgba(217, 70, 37, 0.2)";
    accent_rgba_10 = "rgba(217, 70, 37, 0.1)";
    accent_rgba_30 = "rgba(217, 70, 37, 0.3)";
    accent_rgba_40 = "rgba(217, 70, 37, 0.4)";
    peach_rgba_20 = "rgba(242, 143, 121, 0.2)";
    muted_rgba_40 = "rgba(66, 52, 50, 0.4)";
    zedAppearance = "dark";
  }

