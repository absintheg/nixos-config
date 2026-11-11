{ pkgs, ... }:
{
  users.users.me = {
    isNormalUser = true;
    description = "Myself";
    extraGroups = [
      "networkmanager"
      "wheel"
      "wireshark"
    ];
    shell = pkgs.zsh;
    home = "/home/me";
  };
}
