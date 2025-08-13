{ pkgs, ... }: {
    home.packages = with pkgs; [
        dconf
    ];

    dconf = {
        enable = true;
        settings."org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
        };
    };

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

        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };

        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };
}