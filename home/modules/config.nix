let 
    configDir = ../config;
in {
    home.file = {
        ".config/btop".source = "${configDir}/btop";
        ".config/hypr".source = "${configDir}/hypr";
        ".config/kitty".source = "${configDir}/kitty";
        ".config/mako".source = "${configDir}/mako";
        ".config/waybar".source = "${configDir}/waybar";
        ".config/wlogout".source = "${configDir}/wlogout";
        ".config/wofi".source = "${configDir}/wofi";
    };
}