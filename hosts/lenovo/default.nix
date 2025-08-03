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
}
