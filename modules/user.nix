{ pkgs, ... }:
{
  users.users.me = {
    isNormalUser = true;
    description = "Myself";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    home = "/home/me";
  };
}
