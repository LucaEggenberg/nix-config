{ config, pkgs, lib, ... }: {
#    boot.loader.systemd-boot.enable = true;
#    boot.loader.efi.canTouchEfiVariables = true;
#    boot.loader.efi.efiSysMountPoint = "/boot";
boot.loader.systemd-boot.enable = false;

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
}
