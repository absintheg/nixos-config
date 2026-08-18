{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  imports = [
    ./dns.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  boot.kernelPackages =
    (import inputs.nixpkgs-kernel {
      system = pkgs.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    }).linuxPackages;

  environment.systemPackages =
    with pkgs;
    [
      chromium
      librewolf
      firefox

      wezterm
      ghostty
      alacritty

      qbittorrent
      keepassxc
      gparted
      gimp
      vlc
      emacs
      obsidian
      piper
      baobab
      pavucontrol
    ]
    ++ [
      pkgs-unstable.mullvad-vpn
    ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.hack
    ];
  };

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  # boot.loader.systemd-boot.enable = true;

  # Port for hosting minecraft server
  networking.firewall.allowedTCPPorts = [ 25565 ];
  networking.firewall.allowedUDPPorts = [ 25565 ];

  # Enable networking
  networking.networkmanager.enable = true;

  # VPNs
  services.tailscale.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs-unstable.mullvad;

  # For dual booting
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ara,ru,de";
    variant = "";
    options = "grp:win_space_toggle";
  };

  services.flatpak.enable = true;
  services.ratbagd.enable = true;
}
