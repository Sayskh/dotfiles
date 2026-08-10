{...}: {
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    # PipeWire configuration
    extraConfig.pipewire = {
      "99-audiophile" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [
            44100
            48000
            88200
            96000
            176400
            192000
            352800
            384000
          ];

          # Resampler quality (0-14, 10 is highest quality speex/soxr)
          "resample.quality" = 10;

          # Clock quantum for stable, low-jitter processing
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 512;
          "default.clock.max-quantum" = 2048;
        };
      };
    };

    # WirePlumber Bluetooth Hi-Res Codecs (LDAC, AptX HD, AAC, SBC-XQ)
    extraConfig.wireplumber = {
      "99-bluetooth-codecs" = {
        "wireplumber.settings" = {
          "bluetooth.codecs" = ["ldac" "aptx_hd" "aac" "sbc_xq"];
        };
      };
    };
  };
}


