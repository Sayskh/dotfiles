{
  pkgs,
  lib,
  vars,
  ...
}: let
  gpu = vars.gpu or "nvidia";
in {
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.description;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "render"
      "storage"
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.sessionVariables =
    {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      BROWSER = "zen-browser";
      XDG_CURRENT_DESKTOP = "MangoWC";
      XDG_SESSION_TYPE = "wayland";
      NIXOS_OZONE_WL = "1";
    }
    // (lib.optionalAttrs (gpu == "nvidia") {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
    })
    // (lib.optionalAttrs (gpu == "amd") {
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    })
    // (lib.optionalAttrs (gpu == "intel") {
      LIBVA_DRIVER_NAME = "iHD";
    });
}
