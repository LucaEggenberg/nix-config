{ config, pkgs, lib, ... }: {
#    boot.loader.systemd-boot.enable = true;
#    boot.loader.efi.canTouchEfiVariables = true;
#    boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.loader.grub.extraEntries = ''
    menuentry 'Arch Linux' {
    search --no-floppy --fs-uuid --set=root BE50-4324

    linux /vmlinuz-linux root=UUID=ee0d0d44-0d3c-4252-b0c1-53f6aa5e8bb4 rw quiet loglevel=3
    initrd /initramfs-linux.img
  }
  menuentry 'Arch Linux (Fallback - Manually Configured)' {
    search --no-floppy --fs-uuid --set=root BE50-4324
    
    linux /vmlinuz-linux root=UUID=ee0d0d44-0d3c-4252-b0c1-53f6aa5e8bb4 rw quiet loglevel=3
    initrd /initramfs-linux-fallback.img
  }
  '';
}
