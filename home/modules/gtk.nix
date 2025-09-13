{ pkgs, ... }: {
    home.packages = with pkgs; [
        gnome-themes-extra
    ];

    gtk = {
        enable = true;
        
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-folders;
        };

        font = {
            name = "CaskaydiaMono Nerd Font Mono";
            package = pkgs.nerd-fonts.caskaydia-mono;
        };

        theme.name = "Adwaita-dark";
    };
}