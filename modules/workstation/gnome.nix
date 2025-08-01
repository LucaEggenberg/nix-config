{ pkgs, ... }: {
    services.xserver.desktopManager.gnome.enable = true;
    xdg.portal = {
        enable = true;
        extraPortals = [ 
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
        ];
    };
}