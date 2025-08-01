slef: super: {
    _1password-gui = super._1password-gui.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
            wrapProgram $out/bin/1password --set ELECTRON_OZONE_PLATFORM_HINT "x11"
        '';
    });
}