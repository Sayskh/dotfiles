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
    description = "Hardware GPU profile selection";
  };

  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      extraPackages = lib.mkIf (isAuto || cfg == "intel") (with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ]);
    };

    services.xserver.videoDrivers =
      if (isAuto) then
        ["nvidia" "modesetting"]
      else if (cfg == "nvidia") then
        ["nvidia"]
      else
        ["modesetting"];

    hardware.nvidia = lib.mkIf (isAuto || cfg == "nvidia") {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      powerManagement.enable = false;
      powerManagement.finegrained = false;
    };

    boot.initrd.kernelModules = lib.mkIf (cfg == "amd") ["amdgpu"];

    virtualisation.virtualbox.guest.enable = lib.mkIf (isAuto || cfg == "virtualbox") true;
  };
}
