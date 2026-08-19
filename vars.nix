{
  username = "hio";
  hostname = "nixbtw";
  gitUsername = "hio";
  description = "Hio";
  gpu = "nvidia"; # Options: "nvidia", "amd", "intel", "hybrid-intel-nvidia", "hybrid-amd-nvidia", "vm"

  # Optional PCI Bus IDs for hybrid/dual GPU laptops (find via `lspci | grep -E "VGA|3D"`):
  intelBusId = "PCI:0:2:0";
  amdgpuBusId = "PCI:5:0:0";
  nvidiaBusId = "PCI:1:0:0";
}
