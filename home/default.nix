{ nixpkgs, user, version, dotfiles, ... }: {
    
    imports = [
        dotfiles.homeManagerModules.dotfiles
        ./modules/git.nix
        ./modules/packages.nix
    ];

    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";
    
    nixpkgs.config.allowUnfree = true;
    wayland.windowManager.hyprland.enable = true;
}
