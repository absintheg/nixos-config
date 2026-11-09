{ pkgs, ... }:

let
  firewallToolSrc = ../packages/nixos-firewall-tool;
  firewallTool = pkgs.nixos-firewall-tool.overrideAttrs {
    src = firewallToolSrc;
  };
in
{
  environment.systemPackages = [ firewallTool ];
  networking.firewall.enable = true;
}
