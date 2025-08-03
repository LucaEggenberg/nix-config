{ nixpkgs, user, version, catppuccin, ... }: {
    
    imports = [
        catppuccin.homeModules.catppuccin
        ./modules/bash.nix
        ./modules/catppuccin.nix
        ./modules/dotfiles.nix
        ./modules/git.nix
        ./modules/gtk.nix
        ./modules/packages.nix
        ./modules/quickshell.nix
    ];

    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";
    
    nixpkgs.config.allowUnfree = true;
}