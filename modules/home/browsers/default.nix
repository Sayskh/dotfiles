# Browsers — Zen Browser + Brave
{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    # Zen Browser (from flake)
    inputs.zen-browser.packages.${pkgs.system}.default

    # Brave
    pkgs.brave
  ];
}
