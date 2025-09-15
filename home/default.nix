{ pkgs, user, version, catppuccin, nvim-config, ... }: 
let 
    nvim-config-path = "/home/${user.userName}/dev/nvim/nvim";
    flake-config = if pkgs.pathExists nvim-config-path
        then { programs.nvim-config.symlinkPath = nvim-config-path; }
        else { };
in
{
    imports = [        
        catppuccin.homeModules.catppuccin
        nvim-config.homeModules.default
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
