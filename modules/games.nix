{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
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
