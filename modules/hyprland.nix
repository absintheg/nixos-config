{
  pkgs,
  pkgs-unstable,
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
    };

    environment.systemPackages =
      with pkgs;
      [
        noctalia-shell
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
      ]);

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
