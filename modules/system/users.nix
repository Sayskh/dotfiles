{pkgs, ...}: {
  users.users.hio = {
    isNormalUser = true;
    description = "Hio";
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "audio"
      "input"
      "render"
      "storage"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "kitty";
    BROWSER = "zen-browser";
    XDG_CURRENT_DESKTOP = "MangoWC";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";

    # NVIDIA Wayland environment variables
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}



