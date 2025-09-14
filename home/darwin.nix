{ pkgs, nvim-config, ... }: {
    imports = [
        ./home-manager.nix
        nvim-config.homeModules.default
    ];
}
