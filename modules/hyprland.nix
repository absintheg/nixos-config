{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    withUWSM = true;
    xwayland.enable = true;
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
}
