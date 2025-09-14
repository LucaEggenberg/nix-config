{ config, pkgs, user, ... }: {
    nix.enable = true;

    users.users.${user.userName} = {
        name = user.userName;
        shell = pkgs.zsh;
    };

    environment.systemPackages = with pkgs; [
    ];

    
}