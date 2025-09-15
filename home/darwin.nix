{ nixpkgs, version, user, nvim-config, ... }: {
    imports = [
        nvim-config.homeModules.default
        ./modules/zsh.nix
    ];

    home.homeDirectory = "/Users/${user.userName}";
    home.stateVersion = "${version}";
    nixpkgs.config.allowUnfree = true;
}
