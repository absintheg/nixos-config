{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;
  # Newer kernel versions may need
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  programs.virt-manager.enable = true;

  environment.systemPackages = [
    pkgs.qemu_kvm
    pkgs.qemu-utils
  ];
}
