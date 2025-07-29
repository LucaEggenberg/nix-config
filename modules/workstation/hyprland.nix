{ pkgs, ... }: {
    security.polkit.enable = true;
    programs.hyprland.enable = true;
    
    environment.systemPackages = with pkgs; [
        kitty
        mako
        qt5.qtwayland
        qt6.qtwayland
        waybar
        wl-clipboard
        wlogout
        wofi
        hyprcursor
        grim
        slurp
    ];
}