{ config, ... }:
{
  imports = [
    ./desktop-hardware.nix

    ../modules/common.nix
    ../modules/gamedev.nix
    ../modules/nvidia.nix
    ../modules/games.nix
    ../modules/physical.nix
    ../modules/virtualisation.nix
    ../modules/obs.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
    ../modules/pasteblock.nix

    ../modules/kde.nix
    ../modules/hyprland.nix
  ];

  # Enable KDE plasma as default
  my.plasma.enable = config.specialisation != { };

  specialisation = {
    plasma.configuration = {
      my.plasma.enable = true;
    };

    hyprland.configuration = {
      my.hyprland.enable = true;
    };
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 12 * 1024;
    }
  ];
}
