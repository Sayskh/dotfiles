{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ── FOR VIRTUALBOX TESTING ──
  # Enable VirtualBox Guest Additions (3D acceleration, shared clipboard, auto-resize)
  virtualisation.virtualbox.guest.enable = true;

  # ── FOR BARE METAL NVIDIA (Uncomment when installing on real hardware) ──
  # services.xserver.videoDrivers = ["nvidia"];
  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };
}


