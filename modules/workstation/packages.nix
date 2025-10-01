{ pkgs, user, ... }: {
    environment.systemPackages = with pkgs; [
        firefox
        nautilus
        kubectl
        papirus-folders
        wl-clipboard
        cliphist
    ];
}