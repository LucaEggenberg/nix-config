{ nixpkgs, version, user, nvim-config, ... }: {
    home.homeDirectory = "/Users/${user.userName}";
    home.stateVersion = "${version}";
    nixpkgs.config.allowUnfree = true;
    
    imports = [
        nvim-config.homeModules.default
        ./modules/zsh.nix
    ];

    
}
