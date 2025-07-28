# NixOS Config

This repo houses my NixOS configuration managed as a [Nix Flake](https://nixos.wiki/wiki/Flakes)

## Usage
### 1. Enable Nix Flakes

Enable the experimental Flakes feature. add the following to `/etc/nixos/configuration.nix` and rebuild:

```nix
# /etc/nixos/configuration.nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

```bash
sudo nixos-rebuild switch
```

### 2. Clone Repository
```bash
git clone https://github.com/LucaEggenberg/nix-config.git ~/nix-config
cd ~/nix-config
```

### 3. Generate Hardware Configuration
```bash
# replace <hostname>
sudo nixos-generate-config --no-files --show-console-config > ./hosts/<hostname>/hardware.nix
```

### 4. Set Environment Variables
```bash
export NIX_GIT_EMAIL="your.email@example.com"
```

### 5. Rebuild the System
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```