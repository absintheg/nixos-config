{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          mangohud
          gamescope
          gamemode
        ];
    })
    lutris
    mangohud
    prismlauncher

    gnome-2048
    kdePackages.blinken
    kdePackages.khangman
    kdePackages.kapman
    kdePackages.kpat
    kdePackages.kmines
    kdePackages.kblocks
    kdePackages.knights
    kdePackages.ktuberling
  ];

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
