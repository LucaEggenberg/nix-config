{ config, pkgs, lib, ... }: {
    imports = [
        ./hardware.nix
    ];
    
    networking.hostname = "nix";
    
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
        powermanagement.enable = true;
        powerManagement.finegrained = false;
        open = true;
        nvidiaSettings = true;
    };
}
