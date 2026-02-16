{ pkgs, ... }: {
    imports = [
        ./ambiguous.nix
        ./audio.nix
        ./bluetooth.nix
        ./dm.nix
        ./gnome.nix
        ./hyprland.nix
        ./packages.nix
        ./_1password.nix
    ];
}