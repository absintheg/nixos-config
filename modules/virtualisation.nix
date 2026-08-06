{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;
  # Newer kernel versions may need
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  programs.virt-manager.enable = true;

  environment.systemPackages = [
    pkgs.qemu
  ];
}
