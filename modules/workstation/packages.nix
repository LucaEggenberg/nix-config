{ pkgs, user, ... }: {
    environment.systemPackages = with pkgs; [
        firefox
        nautilus
        kubectl
        papirus-folders
        wl-clipboard
        cliphist
    ];

    programs._1password.enable = true;
    programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ user.userName ];
    };
}