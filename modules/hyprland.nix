{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  programs.hyprland = {
    enable = true;
    package = pkgs-unstable.hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
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
  ])
  ++ (with pkgs; [
    wl-clipboard
	plasma-systemmonitor
  ]);

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
