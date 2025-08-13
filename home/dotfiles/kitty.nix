{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        kitty
    ];

     programs.kitty.settings = {
        shell_integration = "enabled";
        confirm_os_window_close = -1;

        # The basic colors
        foreground = "#c6d0f5";
        background = "#303446";
        selection_foreground = "#303446";
        selection_background = "#f2d5cf";

        # Cursor colors
        cursor = "#f2d5cf";
        cursor_text_color = "#303446";

        # URL underline color when hovering with mouse
        url_color = "#f2d5cf";

        # Kitty window border colors
        active_border_color = "#babbf1";
        inactive_border_color = "#737994";
        bell_border_color = "#e5c890";

        # OS Window titlebar colors
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";

        # Tab bar colors
        active_tab_foreground = "#232634";
        active_tab_background = "#ca9ee6";
        inactive_tab_foreground = "#c6d0f5";
        inactive_tab_background = "#292c3c";
        tab_bar_background = "#232634";

        # Colors for marks (marked text in the terminal)
        mark1_foreground = "#303446";
        mark1_background = "#babbf1";
        mark2_foreground = "#303446";
        mark2_background = "#ca9ee6";
        mark3_foreground = "#303446";
        mark3_background = "#85c1dc";

        # The 16 terminal colors
        color0 = "#51576d";
        color1 = "#e78284";
        color2 = "#a6d189";
        color3 = "#e5c890";
        color4 = "#8caaee";
        color5 = "#f4b8e4";
        color6 = "#81c8be";
        color7 = "#b5bfe2";
        color8 = "#626880";
        color9 = "#e78284";
        color10 = "#a6d189";
        color11 = "#e5c890";
        color12 = "#8caaee";
        color13 = "#f4b8e4";
        color14 = "#81c8be";
        color15 = "#a5adce";
    };
}