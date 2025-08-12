{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        mako
    ];

    services.mako = {
        enable = true;

        anchor = "top-right";
        font = "monospace 10";
        backgroundColor = "#303446";
        textColor = "#c6d0f5";
        width = 350;
        margin = "20,20,0,0";
        padding = 10;
        borderSize = 2;
        borderColor = "#737994";
        borderRadius = 5;
        defaultTimeout = 10000;
        groupBy = "summary";
        
        grouped = {
            format = "<b>%s</b>\n%b";
        };
    };
}