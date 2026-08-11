# dotfiles

A NixOS desktop built on **MangoWC + Quickshell (Material Design 3)** — fully declarative system config via NixOS Flakes, user config via Home Manager, CachyOS kernel, M3 dynamic wallpaper theming, and an audiophile-grade PipeWire audio pipeline.

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
| WM | MangoWC (Wayland dwl + scenefx) |
| Shell / Bar | Quickshell (QML Material Design 3) |
| Terminal | Kitty |
| Editor | Neovim (lazy.nvim) |
| Shell Prompt | Zsh + Oh My Zsh + Starship |
| File Manager | Yazi + Thunar |
| GPU Driver | Auto-Detect (`hardwareProfile = "auto"`) — NVIDIA / AMD / Intel / VirtualBox |
| Audio | PipeWire (Dynamic sample rate 44.1kHz-384kHz, EasyEffects DSP) |
| Music | MPD + rmpc / Spotify |
| Browsers | Zen Browser (default) + Brave |
| Launcher | Quickshell SearchOverlay |
| Display Manager | SDDM (Astronaut Modern Theme) |
| Fonts | JetBrainsMono Nerd Font + Material Symbols Rounded |

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
├── hardware-configuration.nix
├── LICENSE                             GPL-3.0 License
├── modules/
│   ├── home/                           Home Manager modules
│   │   ├── browsers/                   Zen Browser + Brave
│   │   ├── desktop/                    MangoWC, GTK, Qt, Cursor
│   │   ├── dev/                        Git + Delta, Neovim LSPs, tools
│   │   ├── media/                      Vesktop, MPV, cava, rmpc, mpc
│   │   ├── shell/                      Zsh, Oh My Zsh, Starship
│   │   ├── packages.nix                General user packages
│   │   └── symlinks.nix                xdg.configFile symlink wiring
│   │
│   └── system/                         NixOS system modules
│       ├── boot/                       Plymouth + CachyOS kernel
│       ├── hardware/                   GPU auto-detection & Bluetooth
│       ├── display/                    MangoWC compositor + SDDM Astronaut
│       ├── networking/                 NetworkManager + DNS-over-TLS
│       ├── services/                   PipeWire audiophile + MPD
│       ├── fonts.nix                   JetBrainsMono NF, M3 Symbols
│       ├── nix.nix                     GC, optimise, binary caches
│       ├── packages.nix                System-wide CLI tools
│       ├── security.nix                rtkit, polkit, PAM
│       └── users.nix                   User hio, session variables
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

## Installation

```bash
# 1. Mount root and boot partitions
mount /dev/sda2 /mnt
mkdir -p /mnt/boot
mount /dev/sda1 /mnt/boot

# 2. Generate hardware config & clone dotfiles
nixos-generate-config --root /mnt
mkdir -p /mnt/home/hio
git clone https://github.com/Sayskh/dotfiles.git /mnt/home/hio/dotfiles

# 3. Install NixOS Flake
cd /mnt/home/hio/dotfiles
nixos-install --flake .#nixbtw

# 4. Set password and reboot
passwd hio
reboot
```

---

## Acknowledgements & Inspiration

Special thanks to the following open-source projects for design inspiration and references:

- **[end4-pC (IllogicalImpulse)](https://github.com/pctrade/end4-pC)** — Outstanding Material Design 3 QML desktop shell reference, widget design concepts, and dynamic color system.
- **[MangoWC](https://github.com/DreamMaoMao/mangowc)** — Scenefx-powered Wayland compositor.
- **[Quickshell](https://git.outfoxxed.me/outfoxxed/quickshell)** — Flexible QML desktop shell framework.

---

## License

This project is licensed under the **GNU General Public License v3.0** (GPL-3.0). See the [`LICENSE`](./LICENSE) file for full details.
