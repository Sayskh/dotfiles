{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./modules/system/boot
    ./modules/system/hardware
    ./modules/system/display
    ./modules/system/networking
    ./modules/system/services
    ./modules/system/fonts.nix
    ./modules/system/nix.nix
    ./modules/system/packages.nix
    ./modules/system/security.nix
    ./modules/system/users.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # State version for NixOS stateful data backwards compatibility
  system.stateVersion = "25.11";
}
