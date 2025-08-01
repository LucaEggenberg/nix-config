{ nixpkgs, user, version, dotfiles, catppuccin, ... }: {
    
    imports = [
        dotfiles.homeManagerModules.dotfiles
        catppuccin.homeManagerModules.catppuccin
        ./modules/git.nix
        ./modules/packages.nix
        ./modules/catppuccin.nix
    ];

    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";
    
    nixpkgs.config.allowUnfree = true;
    wayland.windowManager.hyprland.enable = true;
}
