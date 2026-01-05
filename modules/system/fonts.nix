{ config, pkgs, ... }: {
    fonts.packages = with pkgs; [
        font-awesome
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        nerd-fonts.caskaydia-mono
    ];
}
