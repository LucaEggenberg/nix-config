{ pkgs, ... }: {
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-folders;
    };
    
    font = {
      name = "CaskaydiaMono Nerd Font Mono";
      package = pkgs.nerd-fonts.caskaydia-mono;
    };

    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };
}