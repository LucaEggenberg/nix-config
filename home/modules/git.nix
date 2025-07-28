{ user, ... }: {
    programs.git = {
        enable = true;
        userName = "${user.fullName}";
        userEmail = builtins.getEnv "NIX_GIT_EMAIL";
    };
}
