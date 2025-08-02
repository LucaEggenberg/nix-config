{ pkgs, ... }: {
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

        theme = {
            name = "Nordic";
            package = pkgs.nordic;
        };

        gtk3.extraConfig = {
            Settings = ''
                gtk-application-prefer-dark-theme = 1;
            '';
        };

        gtk4.extraConfig = {
            Settings = ''
                gtk-application-prefer-dark-theme = 1;
                '';
        };
    };
}