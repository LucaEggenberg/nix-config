{ pkgs, quickshell, ... }: {
    home.packages = [
        (quickshell.packages.${pkgs.system}.default)
	pkgs.kdePackages.qtdeclarative
    ];

    qt.enable = true;
}