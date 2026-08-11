{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["ata_piix" "uhci_hcd" "ehci_pci" "ahci" "sd_mod" "sr_mod" "virtio_pci" "nvme" "usbhid"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel" "kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  swapDevices = [];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
