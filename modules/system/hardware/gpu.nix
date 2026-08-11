{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hardwareProfile;
  isAuto = cfg == "auto";
in {
  options.hardwareProfile = lib.mkOption {
    type = lib.types.enum ["auto" "nvidia" "amd" "intel" "virtualbox" "generic"];
    default = "auto";
    description = "Hardware GPU profile: 'auto' detects NVIDIA, AMD, Intel, or VirtualBox automatically";
  };

  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      # Extra acceleration packages (safe for Intel/AMD/NVIDIA)
      extraPackages = lib.mkIf (isAuto || cfg == "intel") (with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ]);
    };

    # ── Driver Selection ──
    services.xserver.videoDrivers =
      if (isAuto) then
        ["nvidia" "modesetting"]
      else if (cfg == "nvidia") then
        ["nvidia"]
      else
        ["modesetting"];

    # ── NVIDIA Settings (Active for auto or nvidia) ──
    hardware.nvidia = lib.mkIf (isAuto || cfg == "nvidia") {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };

    # ── AMD Kernel Module ──
    boot.initrd.kernelModules = lib.mkIf (cfg == "amd") ["amdgpu"];

    # ── VirtualBox Guest Service (Auto-detects hypervisor) ──
    virtualisation.virtualbox.guest.enable = lib.mkIf (isAuto || cfg == "virtualbox") true;
  };
}
