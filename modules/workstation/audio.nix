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
        serviceConfig = {
            ExecStart = "${pkgs.easyeffects}/bin/easyeffects --gapplication-service";
            Restart = "on-failure";
        };
        wantedBy = [ "default.target" ];
    };
}
