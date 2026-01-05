{ pkgs, ... }: {
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
        pamixer
        pavucontrol
        easyeffects
    ];

    systemd.user.services.easyeffects = {
        enable = true;
        description = "audio effects for pipewire";

        wantedBy = [ "hyprland-session.target" ];
        partOf   = [ "hyprland-session.target" ];
        
        after = [
            "hyprland-session.target"
            "pipewire.service"
            "wireplumber.service"
        ];
        
        serviceConfig = {
            ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
            
            Restart = "on-failure";
            RestartSec = 2;
            StartLimitIntervalSec = 0;
            Environment = "GTK_USE_PORTAL=1";
        };
    };
}
