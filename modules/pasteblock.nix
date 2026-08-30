{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xmousepasteblock
  ];
  systemd.user.services.xmousepasteblock = {
    description = "Disable middle mouse button paste";

    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.xmousepasteblock}/bin/xmousepasteblock";
      Restart = "on-failure";
    };
  };
}
