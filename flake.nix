{
    description = "My personal nix config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        sddm-astronaut-theme = {
            url = "github:Keyitdev/sddm-astronaut-theme/master";
            flake = false;
        };
    };

    outputs = inputs@{ self, nixpkgs, home-manager, sddm-astronaut-theme, ... }:
    let
        user = {
            userName = "luca";
            fullName = "Luca Eggenberg";
        };
        
        version = "25.05";

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
                    inherit self nixpkgs home-manager sddm-astronaut-theme user version;
                };
                modules = workstationBase ++ [
                    ./hosts/desktop
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = {
                            inherit user nixpkgs;
                        };
                    }
                ];
            };
        };
    };
}   
