{
  pkgs,
  lib,
  inputs,
  modulesPath,
  ...
}@args:
{
  image.fileName = "custom-nixos.iso";
  isoImage.volumeID = "CUSTOM_NIXOS";
  isoImage.edition = "custom";
  isoImage.showConfiguration = lib.mkDefault false;

  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-graphical-base.nix")

    ../modules/common.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
    ../modules/firewall.nix

    ../modules/kde.nix
    ../modules/niri.nix
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

  specialisation = {
    plasma.configuration = {
      isoImage.showConfiguration = true;
      isoImage.configurationName = "KDE Plasma";
    }
    // (import ../modules/kde.nix args);
    niri.configuration = {
      isoImage.showConfiguration = true;
      isoImage.configurationName = "Niri";
    }
    // (import ../modules/niri.nix args);
  };

  services.cloudflare-warp.enable = true;

  # Quad9 DNS
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];

  systemd.tmpfiles.settings."desktop-config" = {
    "/home/nixos/.config" = {
      d = {
        user = "nixos";
        group = "users";
        mode = "0755";
      };
      "C+" = {
        argument = "${inputs.desktop-config}/.config";
        user = "nixos";
        group = "users";
      };
    };
  };
}
