{ pkgs, pkgs-unstable, ... }:
{
  environment.systemPackages =
    with pkgs;
    [
      prismlauncher

      bottles
      lutris
    ]
    ++ [
      (pkgs-unstable.heroic.override {
        extraPkgs =
          pkgs': with pkgs'; [
            gamescope
            gamemode
          ];
      })
    ];

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
