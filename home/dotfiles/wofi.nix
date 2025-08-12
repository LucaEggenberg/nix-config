{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        pkgs.wofi
    ];
    home.file.".config/wofi/config".source = ./assets/wofi/config;
    home.file.".config/wofi/style.css".source = ./assets/wofi/style.css;    
}