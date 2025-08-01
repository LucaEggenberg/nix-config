{ ... }: {
    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    imports = [
        ./audio.nix
        ./hyprland.nix
        ./packages.nix
        ./sddm.nix
    ];
}