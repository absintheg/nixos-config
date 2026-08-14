{
  pkgs,
  pkgs-unstable,
  inputs,
  ...
}:
{
  environment.systemPackages =
    with pkgs;
    [
      (pkgs.prismlauncher.override {
        prismlauncher-unwrapped = pkgs.prismlauncher-unwrapped.overrideAttrs (old: {
          version = "custom";
          src = inputs.prism-launcher;
        });
      })

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
