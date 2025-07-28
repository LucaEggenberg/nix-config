{ pkgs, ... }: {
    home.packages = with pkgs; [
        protonmail-desktop
        protonvpn-gui
        spotify
        _1password-gui
        vscode
    ];    
}
