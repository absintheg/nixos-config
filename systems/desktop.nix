{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./desktop-hardware.nix

    ../modules/user.nix
    ../modules/common.nix
    ../modules/common-dev.nix
    ../modules/nvidia.nix
    ../modules/games.nix
    ../modules/native.nix
    ../modules/bluetooth.nix
    ../modules/audio.nix
    ../modules/ssh.nix
    ../modules/pasteblock.nix

    ../modules/niri.nix
    ../modules/kde.nix
  ];

  environment.systemPackages = with pkgs; [
    (pkgs.callPackage ../packages/mumble-pipewire-fixed.nix { })
    murmur
    blender
    piper
    krita
    wineWow64Packages.stable
  ];

  systemd.services.murmur-gaming = {
    description = "Mumble Gaming Server";

    serviceConfig = {
      ExecStart = "${pkgs.murmur}/bin/murmurd -fg -ini /etc/murmur/gaming.ini";
      Restart = "on-failure";
    };
  };

  # Port for hosting minecraft server
  networking.firewall.allowedTCPPorts = [
    25565
    64738
  ];
  networking.firewall.allowedUDPPorts = [
    25565
    4445
    64738
  ];

  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
  };

  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark;

  services.ratbagd.enable = true;
  services.cloudflare-warp.enable = true;

  my.niri.enable = config.specialisation != { };

  specialisation = {
    plasma.configuration = {
      my.plasma.enable = true;
    };
  };

  services.tailscale.enable = true;
  systemd.services.tailscaled = {
    wantedBy = lib.mkForce [ ];
  };

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  virtualisation = {
    waydroid.enable = true;
    waydroid.package = pkgs.waydroid-nftables;
    libvirtd.enable = true;
  };

  programs.virt-manager.enable = true;
}
