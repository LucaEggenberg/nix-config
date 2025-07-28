{ pkgs, sddm-astronaut-theme, ... }: {
    
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;

        theme = "sddm-astronaut-theme";

        extraConfig = ''
            [Theme]
            Current=${config.services.displayManager.sddm.theme}

            [InputMethod]
            XkbLayout=ch
            XkbVariant=
        '';

        extraThemes = [ sddm-astronaut-theme ];

        fonts.fontDir.enable = true;
        fonts.fonts = [
            (pkgs.callPackage (
                { lib, stdenv, fetchurl, }:
                stdenv.mkDerivation {
                    pname = "sddm-astronaut-theme-fonts";
                    version = "1.0";
                    src = "${sddm-astronaut-theme}/Fonts";
                    installPhase = ''
                        mkdir -p $out/share/fonts/opentype
                        cp -r $src/* $out/share/fonts/opentype/
                    '';
                }
            ) {})
        ];

        qt = {
            enable = true;
            qml.enable = true;
            virtualKeyboard.enable = true;
            virtualKeyboard.enableInputMethod = true;
        }
    };
}

