{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.quickshell.packages.${pkgs.system}.default
    vesktop
    mpv
    cava
    rmpc
    mpc
    playerctl
    grim
    slurp

  ];
}

