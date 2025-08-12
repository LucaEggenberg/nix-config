{ config, pkgs, ... }: {
    programs.wlogout = {
        enable = true;

        layout = [
            {
                label = "reboot";
                action = "systemctl reboot";
                text = "Reboot";
                keybind = "r";
            }
            {
                label = "shutdown";
                action = "systemctl poweroff";
                text = "Shutdown";
                keybind = "s";
            }
            {
                label = "logout";
                action = "hyprctl dispatch exit";
                text = "Logout";
                keybind = "l";
            }
        ];
    };

    home.file.".config/wlogout/style.css".source = ../assets/wlogout/style.css;
    home.file.".config/wlogout/icons".source = ../assets/wlogout/icons;
}