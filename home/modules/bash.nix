{ ... }: {
    programs.bash = {
        enable = true;

        initExtra = ''
            if [ -f "$HOME/.profile" ]; then
                . "$HOME/.profile"
            fi

            if [ "$TERM" = "xterm-kitty" ]; then
                alias ssh="kitty +kitten ssh"
            fi

            PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]\$\[\033[0m\] '
        '';

        shellAliases = {
            rebuild = "cd ~/nix-config && sudo nixos-rebuild switch --flake .#$NIX_HOST; cd -";
            ".." = "cd ..";
            "..." = "cd ../..";
            vi = "nvim";
            vim = "nvim";
            mkdir = "mkdir -pv";
        };
    };
}