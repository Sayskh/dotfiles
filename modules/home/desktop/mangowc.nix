{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.mangowc.packages.${pkgs.system}.mangowc
  ];

  home.file.".config/mangowc/autostart.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash

      swww-daemon &
      sleep 0.5
      swww img ~/Pictures/Wallpapers/default.png --transition-type grow --transition-duration 1 &

      ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &

      quickshell &
    '';
  };
}

