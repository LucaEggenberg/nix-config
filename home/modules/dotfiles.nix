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
            "waybar"
            "wlogout"
            "wofi"
        )

        for f in "''${dotfiles[@]}"; do
            src="${clone-dir}/.stow-targets/.config/$f"
            target="$HOME/.config/$f"

            if [ -e "$target" ]; then
                rm -rf $target
            fi;
            
            ${pkgs.coreutils}/bin/ln -s -T "$src" "$target"
        done

        find ${clone-dir} -type f -name "*.sh" -exec chmod +x {} +
    '';
}