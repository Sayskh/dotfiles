{pkgs, ...}: {
  services.mpd = {
    enable = true;
    user = "hio";
    musicDirectory = "/home/hio/Music";
    extraConfig = ''
      audio_output {
        type          "pipewire"
        name          "PipeWire Native Output"
        auto_resample "no"
      }

      audio_output {
        type          "fifo"
        name          "Visualizer"
        path          "/tmp/mpd.fifo"
        format        "44100:16:2"
      }
    '';
  };

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };
}


