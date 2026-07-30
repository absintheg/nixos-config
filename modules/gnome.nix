{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages =
    with pkgs;
    with gnomeExtensions;
    [
      blur-my-shell
      appindicator
      desktop-icons-ng-ding
    ];
}
