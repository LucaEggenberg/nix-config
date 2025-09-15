{ nixpkgs, version, user, nvim-config, ... }:let 
    nvim-config-path = "/Users/${user.userName}/dev/nvim/nvim";
    flake-config = if pkgs.pathExists nvim-config-path
        then { programs.nvim-config.symlinkPath = nvim-config-path; }
        else { };
in {
    imports = [
        nvim-config.homeModules.default
        ./modules/zsh.nix
    ];

    home.homeDirectory = "/Users/${user.userName}";
    home.stateVersion = "${version}";
    nixpkgs.config.allowUnfree = true;
}
