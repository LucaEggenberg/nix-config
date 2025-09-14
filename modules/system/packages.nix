{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        wget
        git
        tmux
        curl
        file
        unzip
        psmisc
    ];
}
