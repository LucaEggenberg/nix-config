{ pkgs, user, ... }: let
    _1password-wrapped = with pkgs; _1password-gui.overrideAttrs(oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + ''
            wrapProgram "$out/share/1password/1password" \
            --set ELECTRON_OZONE_PLATFORM_HINT "x11"
        '';
    });
in {
    programs._1password.enable = true;
    programs._1password-gui = {
        enable = true;
        polkitPolicyOwners = [ user.userName ];
        package = _1password-wrapped;
    };
}