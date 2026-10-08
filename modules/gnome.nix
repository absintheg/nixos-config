{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my.gnome;
in
{
  options.my.gnome.enable = lib.mkEnableOption "Gnome";

  config = lib.mkIf cfg.enable {
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
      gnome.games.enable = false;
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-user-docs
    ];

    environment.systemPackages =
      with pkgs;
      [
        wl-clipboard
        kdePackages.dolphin
        kdePackages.kolourpaint
      ]
      ++ (with pkgs.gnomeExtensions; [
        blur-my-shell
        appindicator
        desktop-icons-ng-ding
      ]);
  };
}
