{
  config,
  pkgs,
  inputs,
  ...
}: {
  boot.kernelPackages =
    inputs.nix-cachyos-kernel.legacyPackages.${pkgs.system}.linuxPackages-cachyos-bore-lto;

  boot.blacklistedKernelModules = ["nouveau"];

  boot.kernelParams = [
    "usbhid.mousepoll=0"
    "usbhid.kbpoll=0"
    "threadirqs"
    "preempt=full"
    "split_lock_detect=off"
    "tsc=reliable"
  ];
}
