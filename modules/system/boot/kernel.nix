{
  config,
  pkgs,
  inputs,
  ...
}: {
  boot.kernelPackages =
    inputs.nix-cachyos-kernel.legacyPackages.${pkgs.system}.linuxPackages-cachyos-bore-lto;

  boot.blacklistedKernelModules = ["nouveau"];
}
