{...}: {
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    extraConfig.pipewire.pipewire-settings = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [44100 48000 88200 96000 176400 192000 352800 384000];
        "resample.quality" = 10;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 1024;
      };
    };

    extraConfig.pipewire-pulse.pulse-settings = {
      "context.modules" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            "pulse.min.req" = "128/48000";
            "pulse.default.req" = "256/48000";
            "pulse.min.frag" = "128/48000";
            "pulse.default.frag" = "256/48000";
          };
        }
      ];
    };

    wireplumber.extraConfig = {
      bluetooth-codecs = {
        "wireplumber.settings" = {
          "bluetooth.codecs" = ["ldac" "aptx_hd" "aptx_ll" "aac" "sbc_xq"];
        };
      };
      alsa-properties = {
        "monitor.alsa.rules" = [
          {
            matches = [{"node.name" = "~alsa_output.*";}];
            actions.update-props = {
              "api.alsa.headroom" = 128;
              "session.suspend-timeout-seconds" = 0;
            };
          }
          {
            matches = [{"node.name" = "~alsa_input.*";}];
            actions.update-props = {
              "api.alsa.headroom" = 128;
              "session.suspend-timeout-seconds" = 0;
            };
          }
        ];
      };
    };
  };
}
