{
  config,
  pkgs,
  lib,
  vars,
  ...
}: let
  gpu = vars.gpu or "nvidia";
  isNvidia = lib.hasInfix "nvidia" gpu;
  isAmd = lib.hasInfix "amd" gpu;
  isIntel = lib.hasInfix "intel" gpu;
  isHybrid = lib.hasPrefix "hybrid" gpu;
  isNvidiaHybrid = isHybrid && isNvidia;

  intelBusId = vars.intelBusId or "PCI:0:2:0";
  amdgpuBusId = vars.amdgpuBusId or "PCI:5:0:0";
  nvidiaBusId = vars.nvidiaBusId or "PCI:1:0:0";
in {
  # Universal OpenGL & Vulkan graphics baseline
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;
      (lib.optionals isNvidia [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ])
      ++ (lib.optionals isAmd [
        amdvlk
        vaapiVdpau
        libvdpau-va-gl
      ])
      ++ (lib.optionals isIntel [
        intel-media-driver
        intel-vaapi-driver
        libvdpau-va-gl
      ]);
    extraPackages32 = with pkgs.pkgsi686Linux;
      (lib.optionals isAmd [
        amdvlk
      ]);
  };

  # Video Drivers Configuration
  services.xserver.videoDrivers =
    if isNvidia
    then ["nvidia"]
    else if isAmd
    then ["amdgpu"]
    else ["modesetting"];

  # NVIDIA Driver & Settings
  hardware.nvidia = lib.mkIf isNvidia {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = isNvidiaHybrid;
    powerManagement.finegrained = isNvidiaHybrid;

    # PRIME Hybrid GPU Configuration (for laptops / multi-GPU with NVIDIA)
    prime = lib.mkIf isNvidiaHybrid {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = lib.mkIf isIntel intelBusId;
      amdgpuBusId = lib.mkIf isAmd amdgpuBusId;
      nvidiaBusId = nvidiaBusId;
    };
  };

  # AMD Kernel Modules in initrd
  boot.initrd.kernelModules = lib.mkIf isAmd ["amdgpu"];

  # Universal prime-run launcher for all dual-GPU combinations (NVIDIA PRIME & Mesa DRI_PRIME)
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "prime-run" ''
      if [ -e /dev/nvidia0 ] || command -v nvidia-smi >/dev/null 2>&1; then
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
      fi
      export DRI_PRIME=1
      exec "$@"
    '')
  ];
}
