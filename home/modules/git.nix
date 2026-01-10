{ user, ... }: {
    programs.git = {
        enable = true;
        settings.user = {
            name = "${user.fullName}";
            email = builtins.getEnv "NIX_GIT_EMAIL";
        };
    };
}
