{ pkgs, ... }: {
    security.polkit.enable = true;
    programs.hyprland.enable = true;
    
    services.gnome.gnome-keyring.enable = true;

    environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        kitty
        mako
        qt5.qtwayland
        qt6.qtwayland
        waybar
        wl-clipboard
        wlogout
        wofi
        grim
        slurp       
    ];
}