{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        adwaita-icon-theme
    ];

    services.desktopManager.gnome.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [ 
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
        ];
    };
}