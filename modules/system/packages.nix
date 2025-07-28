{ config, pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        wget
        git
        vim
        htop
        tmux
        curl
        file
        unzip
        neovim
    ]
}