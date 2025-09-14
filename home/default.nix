{ pkgs, catppuccin, nvim-config, ... }: {
    imports = [
        ./home-manager.nix
        
        catppuccin.homeModules.catppuccin
        nvim-config.homeModules.default
        ./modules/bash.nix
        ./modules/catppuccin.nix
        ./modules/git.nix
        ./modules/gtk.nix
        ./modules/packages.nix
        ./dotfiles
    ];
}
