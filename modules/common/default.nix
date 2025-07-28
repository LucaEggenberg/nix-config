{ config, pkgs, lib, user, ... }: {
    users.users.${user.userName} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
        shell = pkgs.zsh;
    };

    console.keyMap = "ch";
    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_US-UTF-8";
}