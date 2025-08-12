{ pkgs, ... }: {
    imports = [
        ./audio.nix
        ./dm.nix
        ./gnome.nix
        ./packages.nix
    ];
}