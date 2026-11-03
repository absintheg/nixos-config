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

    services = {
      displayManager.sddm = {
        enable = true;
        theme = "catppuccin-mocha-mauve";
        wayland.enable = true;
      };

      # power-profiles-daemon.enable = true;
      # upower.enable = true;
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
      };
    };

    environment.systemPackages =
      with pkgs;
      [
        xwayland-satellite
        wl-clipboard
        (catppuccin-sddm.override {
          flavor = "mocha";
          accent = "mauve";
        })
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
        discover
        spectacle
        plasma-systemmonitor
      ])
      ++ [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
  };
}
