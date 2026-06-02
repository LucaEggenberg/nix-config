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
            {
                output = "eDP-1";
                mode = "2880x1800@90";
                position = "0x0";
                scale = 1.5;
            }
        ];
    };
}
