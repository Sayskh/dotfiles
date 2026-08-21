# dotfiles

A NixOS desktop built on **MangoWC + Quickshell (Material Design 3)** — fully declarative system config via NixOS Flakes, user config via Home Manager, CachyOS kernel, M3 dynamic wallpaper theming.

> `~/dotfiles/config/` is symlinked to `~/.config/` — all app configs live under `config/` and are wired into place by Home Manager via `xdg.configFile` with `mkOutOfStoreSymlink`.

<div align="center">

![NixOS](https://img.shields.io/badge/NixOS-25.11-5277C3?style=flat&logo=nixos)
![MangoWC](https://img.shields.io/badge/MangoWC-scenefx-FF6F00?style=flat)
![Quickshell](https://img.shields.io/badge/Quickshell-QML-CBA6F7?style=flat)
![Kernel](https://img.shields.io/badge/Kernel-CachyOS_BORE-009688?style=flat)
![License](https://img.shields.io/badge/License-GPL--3.0-A6E3A1?style=flat)

</div>

---

## Stack

| Component | Choice |
| --- | --- |
| OS | NixOS (nixos-25.11 stable + unstable overlay) |
| Kernel | CachyOS BORE (LTO + BORE scheduler) |
| WM | MangoWC (Wayland dwl + scenefx + `mmsg` IPC) |
| Shell / Bar | Quickshell (QML Material Design 3) |
| Terminal | Kitty |
| Editor | Neovim (lazy.nvim) |
| Shell Prompt | Fish + Starship |
| File Manager | Yazi + Thunar |
| GPU Driver | NVIDIA Proprietary + Wayland modesetting |
| Audio | PipeWire (Dynamic sample rate 44.1kHz-384kHz, EasyEffects DSP) |
| Music | MPD + rmpc / Spotify |
| Browsers | Zen Browser (default) + Brave |
| Launcher | Quickshell SearchOverlay |
| Display Manager | SDDM (Astronaut Modern Theme) |
| Fonts | JetBrainsMono Nerd Font + Material Symbols Rounded |

---

## Installation

### 1. Clone dotfiles to ~/dotfiles
```bash
git clone https://github.com/Sayskh/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Set your username & hostname in vars.nix
Edit `vars.nix` to match your desired user configuration:
```nix
{
  username = "yourusername";
  hostname = "nixbtw";
  gitUsername = "yourgithub";
  description = "Your Name";

  # Options: "nvidia", "amd", "intel", "hybrid-intel-nvidia", "hybrid-amd-nvidia", "hybrid-intel-amd", "hybrid-amd-amd", "hybrid-intel-intel", "vm"
  gpu = "nvidia";

  # Optional PCI Bus IDs for NVIDIA PRIME hybrid laptops (find via `lspci | grep -E "VGA|3D"`):
  intelBusId = "PCI:0:2:0";
  amdgpuBusId = "PCI:5:0:0";
  nvidiaBusId = "PCI:1:0:0";
}
```

### 3. Copy hardware-configuration.nix (if fresh install)
```bash
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/
```

### 4. Rebuild system
```bash
sudo nixos-rebuild switch --flake ~/dotfiles#nixbtw
```
*(Replace `nixbtw` with the hostname you set in `vars.nix`)*

---

## Hardware & Latency Tuning

This dotfiles ships with **ultra-low-latency hardware configuration out of the box**, no extra tuning required.

| Metric | Windows Default | This Dotfiles |
| --- | --- | --- |
| Audio Latency (round-trip) | ~30–50ms (WASAPI) | ~5.3ms (PipeWire quantum 256) |
| USB Mouse Polling | 125Hz (8ms) | 1000Hz (1ms) |
| USB Keyboard Polling | 125Hz (8ms) | 1000Hz (1ms) |
| Keyboard Repeat Delay | 500ms | 200ms |
| Mouse Acceleration | Enabled | Disabled (flat 1:1 raw) |
| Kernel Preemption | None (NT) | Full (CachyOS BORE) |
| IRQ Threading | No | Yes |
| Network QDisc | pfifo_fast | CAKE + BBR |

**Key features:**
- PipeWire with hi-res rates up to 384kHz and SoX ultra-quality resampling
- Bluetooth LDAC / aptX HD / aptX Low Latency with fast-connect tuning
- Performance CPU governor with RAM-first swap policy
- Threaded IRQs and full kernel preemption for stutter-free gaming

---

## Flake Inputs


| Input | Source |
| --- | --- |
| `nixpkgs` | `github:NixOS/nixpkgs/nixos-25.11` |
| `nixpkgs-unstable` | `github:NixOS/nixpkgs/nixos-unstable` |
| `home-manager` | `github:nix-community/home-manager/release-25.11` |
| `nix-cachyos-kernel` | `github:xddxdd/nix-cachyos-kernel/release` |
| `mangowc` | `github:DreamMaoMao/mangowc` |
| `quickshell` | `git+https://git.outfoxxed.me/outfoxxed/quickshell` |
| `zen-browser` | `github:0xc000022070/zen-browser-flake` |
| `spicetify-nix` | `github:Gerg-L/spicetify-nix` |

---

## Keybindings

| Keybinding | Action |
| --- | --- |
| `Super + Return` | Open Kitty Terminal |
| `Super + B` | Open Zen Browser |
| `Super + E` | Open Thunar File Manager |
| `Super + D` | Toggle Quickshell M3 App Launcher Overlay |
| `Super + Q` | Kill focused window |
| `Super + Shift + Space` | Toggle floating window |
| `Super + F` | Toggle fullscreen mode |
| `Super + 1 .. 9` | Switch to Tag / Workspace 1 .. 9 |
| `Super + Shift + 1 .. 9` | Move window to Tag 1 .. 9 |

---

## Directory Structure

```
dotfiles/
├── configuration.nix                   NixOS system entry config
├── home.nix                            Home Manager user config
├── flake.nix                           Flake inputs and outputs
├── flake.lock
├── vars.nix                            Central user & hostname variables
├── hardware-configuration.nix
├── LICENSE                             GPL-3.0 License
├── modules/
│   ├── home/                           Home Manager modules
│   │   ├── browsers/                   Zen Browser + Brave
│   │   ├── desktop/                    MangoWC, GTK, Qt, Cursor
│   │   ├── dev/                        Git + Delta, Neovim LSPs, tools
│   │   ├── media/                      Vesktop, MPV, cava, rmpc, mpc
│   │   ├── shell/                      Fish, Starship, fastfetch
│   │   ├── packages.nix                General user packages
│   │   └── symlinks.nix                xdg.configFile symlink wiring
│   │
│   └── system/                         NixOS system modules
│       ├── boot/                       Plymouth + CachyOS kernel
│       ├── hardware/                   NVIDIA proprietary GPU & Bluetooth
│       ├── display/                    MangoWC compositor + SDDM Astronaut
│       ├── networking/                 NetworkManager + DNS-over-TLS
│       ├── services/                   PipeWire audio + MPD
│       ├── fonts.nix                   JetBrainsMono NF, M3 Symbols
│       ├── nix.nix                     GC, optimise, binary caches
│       ├── packages.nix                System-wide CLI tools
│       ├── security.nix                rtkit, polkit, PAM
│       └── users.nix                   User setup, session variables
│
└── config/                             App configs → symlinked into ~/.config/
    ├── quickshell/                     Material Design 3 QML Desktop Shell & Services
    ├── mangowc/                        MangoWC compositor config
    ├── kitty/                          Kitty terminal config
    ├── nvim/                           Neovim init.lua & plugin specs
    ├── starship/                       Starship prompt config
    ├── fastfetch/                      Fastfetch config
    └── scripts/                        Wallpaper & M3 color extraction scripts
```

---

## Acknowledgements & Inspiration

Special thanks to the following open-source projects for design inspiration and references:

- **[end4-pC (IllogicalImpulse)](https://github.com/pctrade/end4-pC)** — Outstanding Material Design 3 QML desktop shell reference, widget design concepts, and dynamic color system.
- **[ekremx25/quickshell](https://github.com/ekremx25/quickshell)** — MangoWC native `mmsg` IPC event streaming & multi-monitor management concepts.
- **[MangoWC](https://github.com/DreamMaoMao/mangowc)** — Scenefx-powered Wayland compositor.
- **[Quickshell](https://git.outfoxxed.me/outfoxxed/quickshell)** — Flexible QML desktop shell framework.
- **[robbsbro69/nixos](https://github.com/robbsbro69/nixos)** — NixOS modular configuration structure references.

---

## License

This project is licensed under the **GNU General Public License v3.0** (GPL-3.0). See the [`LICENSE`](./LICENSE) file for full details.
