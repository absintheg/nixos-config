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

  environment.systemPackages = with pkgs; [
    hyprpaper
  ];

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
