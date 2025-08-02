{ config, pkgs, ... }:
let
    repo-url = "https://github.com/LucaEggenberg/dotfiles.git";
    clone-dir = "$HOME/.dotfiles";
in {
    home.packages = with pkgs; [ git ];

    home.activation.manageDotfiles = {
        name = "clone & symlink dotfiles";
        script = ''
            if [ ! -d "${clone-dir}" ]; then
                ${pkgs.git}/bin/git clone ${repo-url} ${clone-dir}
            else
                cd ${clone-dir} && ${pkgs.git}/bin/git pull
            fi;

            local dofiles = (
                "btop"
                "hypr"
                "kitty"
                "mako"
                "waybar"
                "wlogout"
                "wofi"
            )

            for f in "dotfiles[@]"; do
                local src="${clone-dir}/.stow-targets/.config/$f"
                local t="$HOME/.config/$f"

                rm -f $t
                ${pkgs.coreutils}/bin/ln -s -T "$src" "$t"
            done

            find ${clone-dir} -type f -name "*.sh" -exec chmod +x {} +
        '';
    };
};