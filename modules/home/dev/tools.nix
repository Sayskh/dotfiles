{pkgs, ...}: {
  home.packages = with pkgs; [
    jq
    yq
    tmux
    lazygit
    htop
    btop
    fastfetch
  ];
}

