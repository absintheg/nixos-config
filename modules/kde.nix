{ pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    xserver.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];
}
