{ pkgs-unstable, ... }:
{
  environment.systemPackages = [ pkgs-unstable.nixos-firewall-tool ];
  networking.firewall.enable = true;
}
