{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    heroic.override
    {
      extraPkgs =
        pkgs': with pkgs'; [
          mangohud
          gamescope
          gamemode
        ];
    }
    lutris
    mangohud
    prismlauncher
  ];

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
