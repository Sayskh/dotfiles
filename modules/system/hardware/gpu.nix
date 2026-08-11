{
  config,
  pkgs,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Support both NVIDIA hardware and VirtualBox guest fallback
  services.xserver.videoDrivers = ["nvidia" "modesetting"];

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Guest additions for VirtualBox testing
  virtualisation.virtualbox.guest.enable = true;
}
