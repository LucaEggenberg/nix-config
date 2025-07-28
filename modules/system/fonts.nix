{ config, pkgs, ... }: {
    fonts.fonts = with pkgs; [
        font-awesome
        noto-fonts-cjk
        noto-fonts-emoji

        nerd-fonts-caskaydia-mono
    ]
}