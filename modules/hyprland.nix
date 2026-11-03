{
  pkgs,
  pkgs-unstable,
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.my.hyprland;
in
{
  options.my.hyprland.enable = lib.mkEnableOption "Hyprland";

  config = lib.mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = pkgs-unstable.hyprland;
      withUWSM = true;
      xwayland.enable = true;
    };

    services = {
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
        kitty
        wl-clipboard
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
        plasma-systemmonitor
      ])
      ++ [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
