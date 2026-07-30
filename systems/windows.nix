{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    ../modules/common.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "me";
  };

  environment.systemPackages = [
    pkgs.wl-clipboard
  ];
}
