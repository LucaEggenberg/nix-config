{ lib, pkgs, quickshell, ... }: {
    home.packages = with pkgs; [
        kdePackages.qtbase
        kdePackages.qtdeclarative

        qt6.qtdeclarative
        qt6.qt5compat

        (quickshell.packages.${pkgs.system}.default.override {
            withJemalloc = true;
            withQtSvg = true;
            withWayland = true;
            withX11 = false;
            withPipewire = true;
            withPam = true;
            withHyprland = true;
            withI3 = false;
        })
    ];

    home.sessionVariables = {
        QML_IMPORT_PATH = lib.makeSearchPath "qml" [
            "${quickshell.packages.${pkgs.system}.default}/lib/qt-6/qml"
            "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml"
            "${pkgs.qt6.qt5compat}/lib/qt-6/qml"
        ];
    };

    qt.enable = true;
}