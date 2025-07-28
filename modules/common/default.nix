{ config, pkgs, lib, user, ... }: {
    users.users.${user.userName} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
        shell = pkgs.zsh;
    };
    programs.zsh.enable = true;

    console.keyMap = "sg";
    time.timeZone = "Europe/Zurich";
    i18n.defaultLocale = "en_US.UTF-8";
}
