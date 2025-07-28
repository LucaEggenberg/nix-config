{ config, pkgs, lib, user, version, ... }: {
    
    imports = [
        ./modules/config.nix
        ./modules/git.nix
        ./modules/packages.nix
    ];

    home-manager.users.${user.userName} = {
        home.stateVersion = "${version}";
        home.homeDirectory = "/home/${user.userName}";
        programs.zsh.enable = true;   
    };
}
