{ pkgs, ... }: 
let
    _1password-wrapped = with pkgs; _1password-gui.overrideAttrs(oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
            wrapProgram "$out/share/1password/1password" \
            --set ELECTRON_OZONE_PLATFORM_HINT "x11"
        '';
    });
in {
    home.packages = with pkgs; [
        home-manager
        protonmail-desktop
        protonvpn-gui
        spotify
        vscode
        _1password-wrapped
        qbittorrent
        nordic
    ];
}
