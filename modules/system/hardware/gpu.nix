{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hardwareProfile;
in {
  options.hardwareProfile = lib.mkOption {
    type = lib.types.enum ["nvidia" "amd" "intel" "virtualbox" "generic"];
    default = "nvidia";
    description = "Hardware GPU profile for driver and environment configuration";
  };

  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # ── NVIDIA Profile ──
    services.xserver.videoDrivers = lib.mkIf (cfg == "nvidia") ["nvidia"];

    hardware.nvidia = lib.mkIf (cfg == "nvidia") {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };

    # ── AMD Profile ──
    boot.initrd.kernelModules = lib.mkIf (cfg == "amd") ["amdgpu"];

    # ── Intel Profile ──
    hardware.graphics.extraPackages = lib.mkIf (cfg == "intel") (with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ]);

    # ── VirtualBox Profile ──
    virtualisation.virtualbox.guest.enable = lib.mkIf (cfg == "virtualbox") true;
  };
}
