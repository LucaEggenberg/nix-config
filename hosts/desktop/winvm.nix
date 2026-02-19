{ config, pkgs, lib, ... }:

let
  vmName = "win11";
  gpuIDs = [
    "10de:2204" # RTX 3090 Video
    "10de:1aef" # RTX 3090 Audio
    "8086:7a60" # USB
  ];
in
{
  # debug
  services.openssh = {
        enable = true;
        ports = [ 22 ];
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
    };

  # virtualization settings
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      swtpm.enable = true;
      runAsRoot = true;

      verbatimConfig = ''
        nographic = 1
        user = "root"
      '';
    };
  };

  # Allow VT-d/IOMMU
  boot.kernelParams = [ "intel_iommu=on" "iommu=pt" ];
  boot.kernelModules = [ "kvm-intel" ];

  # Boot Entry
  specialisation."WinVM".configuration = {
    system.nixos.label = "WindowsVM";

    boot = {
      kernelParams = lib.mkForce [ 
        "intel_iommu=on"
        "iommu=pt"
        "vfio-pci.ids=${lib.concatStringsSep "," gpuIDs}"
        "video=efifb:off"
        "video=vesafb:off"
        "video=simplefb:off"
        "initcall_blacklist=sysfb_init"
        "pcie_aspm=off" 
        "pci=pcie_bus_perf"
        "isolcpus=4-23" 
        "nohz_full=4-23"
      ];
      
      kernelModules = lib.mkForce [ "vfio_pci" "vfio_iommu_type1" "vfio" "kvm-intel" ];
      blacklistedKernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "nouveau" ];
      extraModprobeConfig = lib.mkForce ''
        options vfio-pci ids=${lib.concatStringsSep "," gpuIDs}
        softdep xhci_hcd pre: vfio-pci
        softdep nvidia pre: vfio-pci
        softdep snd_hda_intel pre: vfio-pci
        options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerDefaultAC=0x1"
      '';
    };

    powerManagement.enable = lib.mkForce false;

    # Disable gui to prevent GPU takeover
    services.xserver.enable = lib.mkForce false;
    services.displayManager.gdm.enable = lib.mkForce false;
    services.desktopManager.gnome.enable = lib.mkForce false; # Add this if using GNOME
    
    # Auto-boot the vm
    systemd.services.autostart-vm = {
      description = "start vm on boot";
      after = [ "libvirtd.service" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.libvirt}/bin/virsh start ${vmName}";
        RemainAfterExit = true;
      };
    };
  };
}
