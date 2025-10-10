{ pkgs, lib, user, version, catppuccin, nvim-config, ... }: 
let
    nvim-dev-path = "/home/${user.userName}/dev/nvim/nvim";
in {
    imports = [
        nvim-config.homeModules.default {
            programs.nvim-config.symlinkPath = nvim-dev-path;
        }
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

    programs = {
        direnv = {
            enable = true;
            enableBashIntegration = true;
            nix-direnv.enable = true;
        };

        bash.enable = true;
    };
}
