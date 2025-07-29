{ config, pkgs, lib, user, ... }: {
    programs.zsh.enable = true;
    users.users.${user.userName} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
        shell = pkgs.zsh;
    };
    
    console.keyMap = "${user.keyMap}";
    time.timeZone = "${user.tz}";
    i18n.defaultLocale = "${user.locale}";
}
