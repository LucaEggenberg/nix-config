{ config, pkgs, lib, user, version, ... }: {
    
    imports = [
        ./modules/config.nix
        ./modules/git.nix
        ./modules/packages.nix
    ];

    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";
    
    nixpkgs.config.allowUnfree = true;   
    programs.zsh.enable = true;
    wayland.windowManager.hyprland.enable = true;
}
