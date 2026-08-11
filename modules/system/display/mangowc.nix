{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.mangowc.packages.${pkgs.system}.default
  ];

  programs.xwayland.enable = true;

  environment.etc."wayland-sessions/mangowc.desktop".text = ''
    [Desktop Entry]
    Name=MangoWC
    Comment=MangoWC Wayland Compositor
    Exec=mangowc
    Type=Application
    DesktopNames=MangoWC
  '';
}
