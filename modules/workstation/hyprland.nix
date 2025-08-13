{ pkgs, ... }: {
    programs.hyprland.enable = true;
    
    environment.systemPackages = with pkgs; [
        qt5.qtwayland
        qt6.qtwayland
    ];

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
}