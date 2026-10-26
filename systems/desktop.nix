{ pkgs, ... }:
{
  imports = [
    ./desktop-hardware.nix

    ../modules/common.nix
    ../modules/nvidia.nix
    ../modules/games.nix
    ../modules/physical.nix
    ../modules/obs.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
    ../modules/pasteblock.nix

    ../modules/kde.nix
  ];

  environment.systemPackages = with pkgs; [
    blender
    piper
    krita
    wineWow64Packages.stable
  ];

  # Port for hosting minecraft server
  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];

  services.ratbagd.enable = true;
  services.cloudflare-warp.enable = true;
  services.tailscale.enable = true;

  my.plasma.enable = true;

  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024;
    }
  ];
}
