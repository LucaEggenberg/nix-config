{ config, pkgs, lib, home-manager, user, version, ... }: {
    environment.sessionVariables = {
        NIX_HOST = "desktop";
    };
    
    imports = [
        ./hardware.nix
        ./switch-capture.nix
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
        freecad-wayland
        chromium
        makemkv
        qemu
        libvirt
        onlyoffice-desktopeditors
        pkgs.gamescope
        kdePackages.kolourpaint
        gimp3
        (pkgs.writeShellScriptBin "qemu-system-x86_64-uefi" ''
            qemu-system-x86_64 \
            -bios ${pkgs.OVMF.fd}/FV/OVMF.fd \
            "$@"
        '')
    ];
    services.hardware.openrgb.enable = true;

    programs.steam = {
        enable = true;
    };

    home-manager.users.${user.userName} = {
        hyprland.custom.monitors = [
            "HDMI-A-1,3840x2160@240,0x0,1.5"
            "HDMI-A-2,2560x1440@60,2560x0,1.0"
        ];
        hyprland.custom.autostarts = [
            "openrgb --startminimized -p default &"
        ];
        hyprland.custom.inputs = { 
            kb_layout = "ch,us";
            kb_options = "grp:win_space_toggle";
        };
    };

    # https://gitlab.gnome.org/GNOME/totem/-/issues/616
    environment.sessionVariables = {
        GDK_GL = "gles";
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
    boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "sg" ];
    boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
        options nvidia_drm fbdev=0
    '';
}
