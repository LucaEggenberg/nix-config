{ config, pkgs, user, ... }: {
    nix.enable = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.optimise.automatic = true;
    nix.gc.automatic = true;
    nix.gc.options = "--delete-older-than 7d";

    system.stateVersion = 6;

    users.users.${user.userName} = {
        home = "/Users/${user.userName}";
        name = user.userName;
        shell = pkgs.zsh;
    };

    environment.systemPackages = with pkgs; [
    ];
}