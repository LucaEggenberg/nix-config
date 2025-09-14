{ config, pkgs, ... }: {
    nix.enable = true;
    system.hostName = "macbook";

    environment.systemPackages = with pkgs; [
    ];

    programs.zsh = {
        enable = true;

        shellAliases = {
            rebuild = "cd ~/dev/nix-config && sudo nix-darwin rebuild switch --flake; cd -";
            ".." = "cd ..";
            "..." = "cd ../..";
            vi = "nvim";
            vim = "nvim";
        }
    };
}