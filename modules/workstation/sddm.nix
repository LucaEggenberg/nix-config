{ pkgs, sddm-astronaut-theme, ... }: {
    
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;

        theme = "sddm-astronaut-theme";

        extraConfig = ''
            [InputMethod]
            XkbLayout=ch
            XkbVariant=
        '';

        themes = [ sddm-astronaut-theme ];

        qml.enable = true;
        virtualKeyboard.enable = true;
        virtualKeyboard.enableInputMethod = true;
    };
}

