{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        firefox
        nautilus
        kubectl
        papirus-folders
    ];
}