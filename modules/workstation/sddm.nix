{ pkgs, sddm-astronaut-theme, ... }: {
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
}

