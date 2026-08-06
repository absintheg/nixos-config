{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "ahci"
    "nvme"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm-intel"
    "vfio"
    "vfio_iommu_type1"
    "vfio_pci"
    "vfio_pci_vfio_virqfd"
  ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "split_lock_detect=off"
    "intel_iommu=on"
    "iommu=pt"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/1fe35c3f-79ca-4035-89ed-98a07a563a0b";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5EB5-3029";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/53e25219-e486-4b1e-a2fb-19b6b3be4ad3";
    fsType = "btrfs";
  };

  fileSystems."/mnt/e" = {
    device = "/dev/disk/by-uuid/3DB917C83DB74456";
    fsType = "ntfs3";
    options = [
      "uid=4325"
    ];
  };

  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/080ADB920ADB7AE0";
    fsType = "ntfs3";
    options = [
      "uid=4325"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
