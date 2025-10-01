{ pkgs, ... }: {
    imports = [
        ./audio.nix
        ./dm.nix
        ./gnome.nix
        ./hyprland.nix
        ./packages.nix
        ./_1password.nix
    ];
}