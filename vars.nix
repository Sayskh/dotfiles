{
  username = "hio";
  hostname = "nixbtw";
  gitUsername = "hio";
  description = "Hio";

  # GPU Configuration:
  # Options:
  #   - "nvidia"               : Single dedicated NVIDIA GPU
  #   - "amd"                  : Single AMD Radeon GPU (iGPU or dGPU)
  #   - "intel"                : Single Intel GPU (iGPU or Intel Arc dGPU)
  #   - "hybrid-intel-nvidia"  : Intel iGPU + NVIDIA dGPU (Optimus laptop / desktop)
  #   - "hybrid-amd-nvidia"    : AMD iGPU + NVIDIA dGPU (Ryzen + NVIDIA laptop)
  #   - "hybrid-intel-amd"     : Intel iGPU + AMD Radeon dGPU
  #   - "hybrid-amd-amd"       : AMD iGPU + AMD Radeon dGPU (AMD Advantage Edition)
  #   - "hybrid-intel-intel"   : Intel iGPU + Intel Arc dGPU
  #   - "vm"                   : Virtual Machine (QEMU/KVM/VirtualBox)
  gpu = "nvidia";

  # Optional PCI Bus IDs for NVIDIA PRIME hybrid laptops (find via `lspci | grep -E "VGA|3D"`):
  intelBusId = "PCI:0:2:0";
  amdgpuBusId = "PCI:5:0:0";
  nvidiaBusId = "PCI:1:0:0";
}
