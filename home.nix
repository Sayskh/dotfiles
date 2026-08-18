{
  config,
  pkgs,
  inputs,
  vars,
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
    username = vars.username;
    homeDirectory = "/home/${vars.username}";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;
}
