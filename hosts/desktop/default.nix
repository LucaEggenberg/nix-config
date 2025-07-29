{ config, pkgs, lib, home-manager, user, version,  ... }: {
    imports = [
        ./hardware.nix
    ];
    
    networking.hostName = "nix";
    
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        steam
        openrgb
        discord
    ];

    # Enable OpenGL
    hardware.graphics = {
        enable = true;
    };

    # load nvidia drivers
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
    };
}
