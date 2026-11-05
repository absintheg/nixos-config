{
  pkgs,
  pkgs-unstable,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.my.niri;
in
{
  options.my.niri.enable = lib.mkEnableOption "Niri";

  config = lib.mkIf cfg.enable {
    programs.niri = {
      enable = true;
      package = pkgs-unstable.niri;
    };

    services.udisks2.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    services.displayManager = {
      sddm = {
        enable = true;
        theme = "sddm-astronaut-theme";
        wayland.enable = true;
        extraPackages = with pkgs; [
          sddm-astronaut
        ];
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
      ];
      config.niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        "org.freedesktop.impl.portal.Settings" = [ "kde" ];
      };
    };

    xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "application/x-directory" = [ "org.kde.dolphin.desktop" ];
    };

    # Replaced for noctalia polkit agent
    # systemd.user.services.polkit-kde-authentication-agent-1 = {
    #   description = "polkit-kde-authentication-agent-1";
    #   wantedBy = [ "graphical-session.target" ];
    #   wants = [ "graphical-session.target" ];
    #   after = [ "graphical-session.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
    #     Restart = "on-failure";
    #     RestartSec = 1;
    #     TimeoutStopSec = 10;
    #   };
    # };

    qt = {
      enable = true;
      platformTheme = "kde";
      style = "breeze";
    };

    environment.systemPackages =
      with pkgs;
      [
        ddcutil
        wl-clipboard
        sddm-astronaut
        bibata-cursors
        adwaita-icon-theme
        xwayland-satellite
        mission-center
      ]
      ++ (with pkgs.kdePackages; [
        dolphin
        ark
        kate
        okular
        kolourpaint
        kcalc
        kclock
        kcharselect
        konsole
        discover

        qtbase
        qtwayland
        qtmultimedia

        solid
        breeze-gtk
        breeze-icons
        qqc2-desktop-style
        kio
        kio-extras
        kio-admin
        kde-cli-tools

        polkit-kde-agent-1
      ])
      ++ [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

    environment.etc."xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=Breeze-Dark
      gtk-application-prefer-dark-theme=true
    '';

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}
