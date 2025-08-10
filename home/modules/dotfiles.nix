{ config, pkgs, ... }:
let
    repo-url = "https://github.com/LucaEggenberg/dotfiles.git";
    clone-dir = "$HOME/.dotfiles";
in {
    home.packages = with pkgs; [ git ];

    home.activation.manageDotfiles =  ''
        if [ ! -d "${clone-dir}" ]; then
            ${pkgs.git}/bin/git clone ${repo-url} ${clone-dir}
        else
            cd ${clone-dir}
            if ! [ -z "$(${pkgs.git}/bin/git status --porcelain)" ]; then
                ${pkgs.git}/bin/git stash push --include-untracked -m "Pre-rebuild local changes"
            fi

            ${pkgs.git}/bin/git pull
        fi;

        dotfiles=(
            "btop"
            "hypr"
            "kitty"
            "mako"
            "wlogout"
            "wofi"
        )

        for f in "''${dotfiles[@]}"; do
            src="${clone-dir}/$f"
            target="$HOME/.config/$f"

            if [ -e "$target" ]; then
                rm -rf $target
            fi;
            
            ${pkgs.coreutils}/bin/ln -s -T "$src" "$target"
        done

        src="${clone-dir}/waybar"
        target="$HOME/.config/waybar"
        mkdir -p $target
	    rm -rf $target/*
        ${pkgs.coreutils}/bin/ln -s -T "$src/colors.css" "$target/colors.css"
        ${pkgs.coreutils}/bin/ln -s -T "$src/config.jsonc" "$target/config.jsonc"
        ${pkgs.coreutils}/bin/ln -s -T "$src/nix/logo.jsonc" "$target/logo.jsonc"
        ${pkgs.coreutils}/bin/ln -s -T "$src/style.css" "$target/style.css"

        find ${clone-dir} -type f -name "*.sh" -exec chmod +x {} +
    '';
}
