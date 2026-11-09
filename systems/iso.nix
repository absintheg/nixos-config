{ pkgs, modulesPath, ... }:
{
  image.fileName = "my-nixos-live.iso";
  isoImage.volumeID = "MY_NIXOS_LIVE";

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ../modules/common.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
    ../modules/kde.nix
    ../modules/firewall.nix
  ];

  boot.zfs.forceImportRoot = false;
  boot.supportedFilesystems = [ "ntfs" ];

  environment.systemPackages = with pkgs; [
    firefox
    alacritty
    keepassxc
    gparted
    pciutils
    usbutils
    vlc
  ];

  my.plasma.enable = true;
  services.cloudflare-warp.enable = true;

  # Quad9 DNS
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];
}
