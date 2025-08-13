{ config, pkgs, lib, home-manager, user, version,  ... }: {
    environment.sessionVariables = {
        NIX_HOST = "lenovo";
    };
    
    imports = [
        ./hardware.nix
    ];
    
    networking.hostName = "lenovo";
    
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
    ];

    home-manager.users.${user.userName} = {
        hyprland.custom.monitors = [
            "eDP-1,2880x1800@90,0x0,1.5"
        ];
    };
}
