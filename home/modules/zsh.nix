{ pkgs, ... }: {
    programs.zsh = {
        enable = true;

        shellAliases = {
            rebuild = "sudo darwin-rebuild switch --flake $HOME/dev/nix-config#macbook";
            ".." = "cd ..";
            "..." = "cd ../..";
            vi = "nvim";
            vim = "nvim";
        };
    };
}