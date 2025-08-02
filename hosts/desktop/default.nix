{ config, pkgs, lib, home-manager, user, version,  ... }: {
    environment.sessionVariables = {
        NIX_HOST = "desktop";
    };
    
    imports = [
        ./hardware.nix
    ];
    
    fileSystems."/media/store" = {
        device = "/dev/disk/by-uuid/84c4a7bc-8f33-410a-b7fa-0a6bc31c3132";
        fsType = "ext4";
        options = [ "defaults" "nofail" ];
    };

    networking.hostName = "nix";
    
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        steam
        steam-run
        openrgb
        discord
    ];

    services.hardware.openrgb.enable = true;

    programs.steam = {
        enable = true;
    };

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

    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
    boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
    '';
}
