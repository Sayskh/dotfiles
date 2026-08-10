{
  config,
  pkgs,
  inputs,
  ...
}: {
  boot.kernelPackages =
    inputs.nix-cachyos-kernel.legacyPackages.${pkgs.system}.linuxPackages-cachyos-bore-lto;

  # Blacklist nouveau in favor of proprietary NVIDIA driver
  boot.blacklistedKernelModules = ["nouveau"];
}

