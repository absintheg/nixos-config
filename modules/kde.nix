{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.plasma;
in
{
  options.my.plasma.enable = lib.mkEnableOption "KDE Plasma";

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.sddm.enable = true;
      displayManager.sddm.wayland.enable = true;
      xserver.enable = true;
    };

    environment.systemPackages =
      with pkgs;
      [
        wl-clipboard
      ]
      ++ (with pkgs.kdePackages; [
        discover # Optional: Software center for Flatpaks/firmware updates
        kcalc # Calculator
        kcharselect # Character map
        kclock # Clock app
        kcolorchooser # Color picker
        kolourpaint # Simple paint program
        ksystemlog # System log viewer
        sddm-kcm # SDDM configuration module
      ]);
  };
}
