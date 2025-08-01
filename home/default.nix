{ nixpkgs, user, version, dotfiles, catppuccin, ... }: {
    
    imports = [
        dotfiles.homeModules.dotfiles
        catppuccin.homeModules.catppuccin
        ./modules/bash.nix
        ./modules/catppuccin.nix
        ./modules/git.nix
        ./modules/gtk.nix
        ./modules/packages.nix
    ];

    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";
    
    nixpkgs.config.allowUnfree = true;
    wayland.windowManager.hyprland.enable = true;
    nixpkgs.overlays = [
        (import ./overlays.nix)
    ];
}
