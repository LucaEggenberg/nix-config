{ config, pkgs, lib, user, ... }: {
    users.users.${user.userName} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "video" "audio" "libvirtd" "kvm" "qemu-libvirtd" ];
        shell = pkgs.bash;
        openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPLTvjhfe4YWatJ3Y19rYj8YHGmiki5AMqDykfkFH5/f"
        ];
    };
    
    console.keyMap = "${user.keyMap}";
    time.timeZone = "${user.tz}";
    i18n.defaultLocale = "${user.locale}";
}
