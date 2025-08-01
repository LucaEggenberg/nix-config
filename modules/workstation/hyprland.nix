{ pkgs, ... }: {
    programs.hyprland.enable = true;
    
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