{ nixpkgs, version, user, nvim-config, ... }: 
let
    nvim-dev-path = "/Users/${user.userName}/dev/nvim/nvim";
in {
    imports = [
        nvim-config.homeModules.default {
            programs.nvim-config.symlinkPath = nvim-dev-path;
        }
        ./modules/zsh.nix
    ];

    home.homeDirectory = "/Users/${user.userName}";
    home.stateVersion = "${version}";
    nixpkgs.config.allowUnfree = true;
}
