{
    description = "My personal nix config";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        home-manager = {
            url = "github:nix-community/home-manager/release-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        quickshell = {
            url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nvim-config = {
          url = "github:LucaEggenberg/nvim";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        nix-darwin = {
            url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hwsuhdx1 = {
            url = "github:LucaEggenberg/hwsuhdx1";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        catppuccin.url = "github:catppuccin/nix";
    };

    outputs = inputs@{ self, nixpkgs, ... }:
    let
        version = "25.11";

        user = {
            userName = "luca";
            fullName = "Luca Eggenberg";
            locale = "en_US.UTF-8";
            tz = "Europe/Zurich";
            keyMap = "sg";
        };

        args = {
            inherit self nixpkgs user version;
            inherit (inputs) catppuccin nvim-config quickshell hwsuhdx1;
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
                    inputs.home-manager.nixosModules.home-manager {
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
                    inputs.home-manager.nixosModules.home-manager {
                        home-manager.users.${user.userName} = import ./home;
                        home-manager.extraSpecialArgs = args;
                    }
                ];
            };
        };

        darwinConfigurations.macbook = inputs.nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            specialArgs = args;
            modules = [
                ./hosts/macbook
                inputs.home-manager.darwinModules.home-manager {
                    home-manager.users.${user.userName} = import ./home/darwin.nix;
                    home-manager.extraSpecialArgs = args;
                }
            ];
        };
    };
}
