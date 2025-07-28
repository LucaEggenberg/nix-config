{ pkgs, ... }: {
    home.packages = with pkgs; [
        protonmail-desktop
        protonvpn-gui
        1password
        spotify
        vscode
    ];    
}