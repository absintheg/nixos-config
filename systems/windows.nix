{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ../modules/common.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "me";
    wslConf.network.generateResolvConf = false;
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = [
    pkgs.wl-clipboard
  ];

  # Quad9 DNS
  networking.nameservers = [
    "9.9.9.9"
    "149.112.112.112"
  ];

}
