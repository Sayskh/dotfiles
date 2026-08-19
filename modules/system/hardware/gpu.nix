{
  config,
  pkgs,
  lib,
  vars,
  ...
}: let
  gpu = vars.gpu or "nvidia";
in {
  # Universal OpenGL & Vulkan graphics baseline
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;
      (lib.optionals (gpu == "nvidia") [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ])
      ++ (lib.optionals (gpu == "amd") [
        amdvlk
        vaapiVdpau
        libvdpau-va-gl
      ])
      ++ (lib.optionals (gpu == "intel") [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ]);
    extraPackages32 = with pkgs.pkgsi686Linux;
      (lib.optionals (gpu == "amd") [
        amdvlk
      ]);
  };

  # ── NVIDIA Configuration ──
  services.xserver.videoDrivers =
    if gpu == "nvidia"
    then ["nvidia"]
    else if gpu == "amd"
    then ["amdgpu"]
    else ["modesetting"];

  hardware.nvidia = lib.mkIf (gpu == "nvidia") {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # ── AMD Kernel Modules ──
  boot.initrd.kernelModules = lib.mkIf (gpu == "amd") ["amdgpu"];
}
