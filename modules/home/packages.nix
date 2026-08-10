{pkgs, ...}: {
  home.packages = with pkgs; [
    pywal
    cliphist
    wtype
    socat
    imagemagick
    ffmpeg
    easyeffects
    lsp-plugins
    calf
  ];
}


