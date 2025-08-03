{
    description = "My personal nix config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        catppuccin.url = "github:catppuccin/nix";
    };

    outputs = inputs@{ self, nixpkgs, home-manager, quickshell, catppuccin, ... }:
    let
        version = "25.05";

        user = {
            userName = "luca";
            fullName = "Luca Eggenberg";
            locale = "en_US.UTF-8";
            tz = "Europe/Zurich";
            keyMap = "sg";
        };

        args = {
            inherit self nixpkgs home-manager user version quickshell catppuccin;
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
                specialArgs = args;
                modules = workstationBase ++ [
                    ./hosts/desktop
                    home-manager.nixosModules.home-manager {
                        home-manager.users.${user.userName} = import ./home;
                        home-manager.extraSpecialArgs = args;
                    }
                ];
            };
            lenovo = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = args;
                modules = workstationBase ++ [
                    ./hosts/lenovo
                    home-manager.nixosModules.home-manager {
                        home-manager.users.${user.userName} = import ./home;
                        home-manager.extraSpecialArgs = args;
                    }
                ];
            };
        };
    };
}