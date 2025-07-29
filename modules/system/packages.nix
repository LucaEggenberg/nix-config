{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        wget
        git
        neovim
        htop
        tmux
        curl
        file
        unzip
    ];
}
