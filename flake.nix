{
    description = "My personal nix config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        dotfiles = {
            url = "git+https://github.com/LucaEggenberg/dotfiles.git?ref=main";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, dotfiles, ... }:
    let
        version = "25.05";

        user = {
            userName = "luca";
            fullName = "Luca Eggenberg";
            locale = "en_US.UTF-8";
            tz = "Europe/Zurich";
            keyMap = "sg";
        };
        
        moduleBase = [
            ./modules/system
            ./modules/common
        ];

        workstationBase = moduleBase ++ [
            ./modules/workstation
        ];
    in {
        nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { 
                    inherit self nixpkgs home-manager user version;
                };
                modules = workstationBase ++ [
                    ./hosts/desktop
                    home-manager.nixosModules.home-manager {
                        home-manager.users.${user.userName} = import ./home;
                        home-manager.extraSpecialArgs = {
                            inherit user nixpkgs version dotfiles;
                        };
                    }
                ];
            };
        };
    };
}