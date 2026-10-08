{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "ntfs" ];

  environment.systemPackages = with pkgs; [
    librewolf
    firefox
    wezterm
    ghostty
    alacritty
    neovide
    qbittorrent
    keepassxc
    gparted
    gimp
    vlc
    obsidian
    vscodium
    zed-editor
    baobab
    pavucontrol
    easyeffects
    gimp
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      # nerd-fonts.terminess-ttf
      # nerd-fonts.jetbrains-mono
      # nerd-fonts.iosevka
      # nerd-fonts.hack
      # nerd-fonts.profont
      # nerd-fonts.cousine
    ];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    theme = "${pkgs.kdePackages.breeze-grub}/grub/themes/breeze";
    efiSupport = true;
  };

  networking.networkmanager.enable = true;

  # Quad9 DNS
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];

  # For dual booting along with windows
  time.hardwareClockInLocalTime = true;

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

  services.xserver.xkb = {
    layout = "us,ara";
    variant = "";
    options = "grp:win_space_toggle";
  };

  services.flatpak.enable = true;
}
