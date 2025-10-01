{ pkgs, ... }: {
    home.packages = with pkgs; [
        home-manager
        protonmail-desktop
        protonvpn-gui
        spotify
        vscode
        qbittorrent
        opentofu
    ];
}
