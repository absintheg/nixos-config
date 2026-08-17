{ pkgs, ... }:
{
  services.pipewire.wireplumber = {
    enable = true;
    extraConfig = {
      "10-bluetooth-msbc" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-msbc" = true;
        };
      };
      "11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  environment.systemPackages = [
    pkgs.pulseaudio
  ];
}
