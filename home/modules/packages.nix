{ pkgs, ... }: {
    home.packages = with pkgs; [
        home-manager
        protonmail-desktop
        protonvpn-gui
        spotify
        _1password-gui
        vscode
    ];    
}
