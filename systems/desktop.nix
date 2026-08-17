{ ... }:
{
  imports = [
    ./desktop-hardware.nix

    ../modules/common.nix
    ../modules/gamedev.nix
    ../modules/nvidia.nix
    ../modules/games.nix
    ../modules/kde.nix
    ../modules/physical.nix
    ../modules/virtualisation.nix
    ../modules/obs.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024;
    }
  ];
}
