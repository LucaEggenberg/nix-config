{ ... }: {
    programs.bash = {
        enable = true;
        shellAliases = {

        };

        promptInit = ''
            export PS1="[\u@\h:\w]"
        '';
    }
}