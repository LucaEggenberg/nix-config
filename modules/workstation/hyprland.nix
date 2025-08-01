{ pkgs, ... }: {
    programs.hyprland.enable = true;
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    
    environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        kitty
        mako
        qt5.qtwayland
        qt6.qtwayland
        waybar
        wlogout
        wofi
        grim
        slurp       
    ];
}