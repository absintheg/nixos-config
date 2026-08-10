{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ../modules/common.nix
    ../modules/dns.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "me";
	wslConf.network.generateResolvConf = false;
  };

  environment.systemPackages = [
    pkgs.wl-clipboard
  ];
}
