{ config, pkgs, lib, user, version, ... }: {
    
    imports = [
        ./modules/config.nix
        ./modules/git.nix
        ./modules/packages.nix
    ];

    nixpkgs.config.allowUnfree = true;
    home.homeDirectory = "/home/${user.userName}";
    programs.zsh.enable = true;
}
