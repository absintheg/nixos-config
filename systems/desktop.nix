{ pkgs, config, ... }:
{
  imports = [
    ./desktop-hardware.nix

    ../modules/user.nix
    ../modules/common.nix
    ../modules/common-dev.nix
    ../modules/nvidia.nix
    ../modules/games.nix
    ../modules/physical.nix
    ../modules/obs.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
    ../modules/pasteblock.nix

    ../modules/niri.nix
    ../modules/kde.nix
  ];

  boot.plymouth = {
    enable = true;
    theme = "spinner";
  };

  environment.systemPackages = with pkgs; [
    blender
    piper
    krita
    wineWow64Packages.stable
  ];

  # Port for hosting minecraft server
  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  services.ratbagd.enable = true;
  services.cloudflare-warp.enable = true;
  services.tailscale.enable = true;

  my.niri.enable = config.specialisation != { };

  specialisation = {
    plasma.configuration = {
      my.plasma.enable = true;
    };
  };

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
  };

  virtualisation.docker.enable = true;

  virtualisation = {
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
    libvirtd.enable = true;
  };

  programs.virt-manager.enable = true;
}
