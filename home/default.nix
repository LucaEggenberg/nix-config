{ pkgs, lib, user, version, catppuccin, nvim-config, ... }: {
    imports = [
        nvim-config.homeModules.default
        catppuccin.homeModules.catppuccin
        ./modules/bash.nix
        ./modules/catppuccin.nix
        ./modules/git.nix
        ./modules/gtk.nix
        ./modules/packages.nix
        ./dotfiles
    ];

    home.homeDirectory = "/home/${user.userName}";
    home.stateVersion = "${version}";
    nixpkgs.config.allowUnfree = true;
}
