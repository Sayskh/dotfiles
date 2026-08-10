{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules/home/desktop
    ./modules/home/shell
    ./modules/home/dev
    ./modules/home/media
    ./modules/home/browsers
    ./modules/home/packages.nix
    ./modules/home/symlinks.nix
  ];

  home = {
    username = "hio";
    homeDirectory = "/home/hio";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}

