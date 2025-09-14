{ pkgs, user, version, ... }: {
    home.stateVersion = "${version}";
    home.homeDirectory = "/home/${user.userName}";

    pkgs.config.allowUnfree = true;
}