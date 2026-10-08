{
  config,
  lib,
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
  ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    "split_lock_detect=off"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/72ec2b2a-d6be-48b4-bb0d-c7d8932c6f74";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1B95-E463";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b85117cc-9099-4c47-9d5a-d2bc8471b9af";
    fsType = "btrfs";
  };

  fileSystems."/mnt/e" = {
    device = "/dev/disk/by-uuid/feefd0cc-ea7d-44d1-9cb2-25573800b733";
    fsType = "btrfs";
    options = [
      "nofail"
    ];
  };

  fileSystems."/mnt/d" = {
    device = "/dev/disk/by-uuid/9549f8f7-a18b-41c6-8aab-791c471157b4";
    fsType = "btrfs";
    options = [
      "nofail"
    ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
