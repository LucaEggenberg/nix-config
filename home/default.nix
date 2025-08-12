{ nixpkgs, user, version, catppuccin, ... }: {
    
    imports = [
        catppuccin.homeModules.catppuccin
        ./modules/bash.nix
        ./modules/catppuccin.nix
        ./modules/git.nix
        ./modules/gtk.nix
        ./modules/packages.nix
        ./dotfiles
    ];

    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";
    
    nixpkgs.config.allowUnfree = true;
}