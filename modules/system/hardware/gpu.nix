{
  config,
  pkgs,
  lib,
  vars,
  ...
}: let
  gpu = vars.gpu or "nvidia";
  isNvidia = gpu == "nvidia" || gpu == "hybrid-intel-nvidia" || gpu == "hybrid-amd-nvidia";
  isAmd = gpu == "amd" || gpu == "hybrid-amd-nvidia";
  isIntel = gpu == "intel" || gpu == "hybrid-intel-nvidia";
  isHybrid = gpu == "hybrid-intel-nvidia" || gpu == "hybrid-amd-nvidia";

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
    powerManagement.enable = isHybrid;
    powerManagement.finegrained = isHybrid;

    # PRIME Hybrid GPU Configuration (for laptops / multi-GPU)
    prime = lib.mkIf isHybrid {
      offload = {
        enable = true;
        enableOffloadCmd = true; # Provides `nvidia-offload` and `prime-run`
      };
      intelBusId = lib.mkIf isIntel intelBusId;
      amdgpuBusId = lib.mkIf isAmd amdgpuBusId;
      nvidiaBusId = nvidiaBusId;
    };
  };

  # AMD Kernel Modules
  boot.initrd.kernelModules = lib.mkIf isAmd ["amdgpu"];

  # Convenience wrapper for PRIME offload
  environment.systemPackages = lib.optionals isHybrid [
    (pkgs.writeShellScriptBin "prime-run" ''
      export __NV_PRIME_RENDER_OFFLOAD=1
      export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
      export __VK_LAYER_NV_optimus=NVIDIA_only
      exec "$@"
    '')
  ];
}
