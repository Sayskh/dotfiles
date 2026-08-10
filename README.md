# dotfiles

A NixOS desktop built on **MangoWC + Quickshell (Material Design 3)** — fully declarative system config via NixOS Flakes, user config via Home Manager, CachyOS kernel, M3 dynamic wallpaper theming, and an audiophile-grade PipeWire audio pipeline.

> `~/dotfiles/config/` is symlinked to `~/.config/` — all app configs live under `config/` and are wired into place by Home Manager via `xdg.configFile` with `mkOutOfStoreSymlink`.

<div align="center">

![NixOS](https://img.shields.io/badge/NixOS-25.11-5277C3?style=flat&logo=nixos)
![MangoWC](https://img.shields.io/badge/MangoWC-scenefx-FF6F00?style=flat)
![Quickshell](https://img.shields.io/badge/Quickshell-QML-CBA6F7?style=flat)
![Kernel](https://img.shields.io/badge/Kernel-CachyOS_BORE-009688?style=flat)
![License](https://img.shields.io/badge/License-MIT-A6E3A1?style=flat)

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
| GPU Driver | NVIDIA Proprietary + Wayland modesetting |
| Audio | PipeWire (Dynamic sample rate 44.1kHz-384kHz, EasyEffects DSP) |
| Music | MPD + rmpc / Spotify |
| Browsers | Zen Browser (default) + Brave |
| Launcher | Quickshell SearchOverlay |
| Display Manager | SDDM |
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
├── modules/
│   ├── home/                           Home Manager modules
│   │   ├── browsers/
│   │   │   └── default.nix             Zen Browser + Brave
│   │   ├── desktop/
│   │   │   ├── default.nix             Imports desktop modules
│   │   │   ├── mangowc.nix             MangoWC autostart script
│   │   │   ├── gtk.nix                 GTK theme (adw-gtk3-dark)
│   │   │   ├── qt.nix                  Qt theme (adwaita-dark)
│   │   │   └── cursor.nix              Bibata cursor + dconf dark mode
│   │   ├── dev/
│   │   │   ├── default.nix             Imports dev modules
│   │   │   ├── git.nix                 Git + Delta diff viewer
│   │   │   ├── editors.nix             Neovim + LSPs + formatters
│   │   │   └── tools.nix               jq, tmux, lazygit, btop...
│   │   ├── media/
│   │   │   ├── default.nix             Imports media modules
│   │   │   └── apps.nix                Vesktop, MPV, cava, rmpc, mpc...
│   │   ├── shell/
│   │   │   ├── default.nix             Imports shell modules
│   │   │   ├── zsh.nix                 Zsh + oh-my-zsh + FZF + eza + yazi
│   │   │   └── starship.nix            Starship prompt
│   │   ├── packages.nix                General packages (pywal, easyeffects...)
│   │   └── symlinks.nix                xdg.configFile mkOutOfStoreSymlink wiring
│   │
│   └── system/                         NixOS system modules
│       ├── boot/
│       │   ├── default.nix             Imports boot modules
│       │   ├── plymouth.nix            Quiet boot + systemd-boot
│       │   └── kernel.nix              CachyOS BORE kernel
│       ├── hardware/
│       │   ├── default.nix             Imports hardware modules
│       │   ├── gpu.nix                 NVIDIA proprietary + Wayland modesetting
│       │   └── bluetooth.nix           Bluetooth + Blueman
│       ├── display/
│       │   ├── default.nix             Imports display modules
│       │   ├── mangowc.nix             MangoWC compositor + SDDM session
│       │   └── portal.nix              XDG Desktop Portal (wlroots + GTK)
│       ├── networking/
│       │   ├── default.nix             Imports networking modules
│       │   ├── base.nix                Hostname nixbtw, NetworkManager, timezone
│       │   └── dns.nix                 systemd-resolved, DoT (Cloudflare + Quad9)
│       ├── services/
│       │   ├── default.nix             Imports services modules
│       │   ├── audio.nix               PipeWire audiophile rate switching + WirePlumber LDAC
│       │   ├── display-manager.nix     SDDM
│       │   ├── media.nix               MPD system service + PipeWire + FIFO
│       │   └── misc.nix                dbus, gvfs, udisks2, gnome-keyring, dconf
│       ├── fonts.nix                   JetBrainsMono NF, Material Symbols Rounded, Inter
│       ├── nix.nix                     GC, optimise, binary caches
│       ├── packages.nix                System-wide CLI tools
│       ├── security.nix                rtkit, polkit, PAM, sudo rules
│       └── users.nix                   User hio, groups, session variables
│
└── config/                             App configs → symlinked into ~/.config/
    ├── quickshell/                     Material Design 3 QML Desktop Shell
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
cp /etc/nixos/hardware-configuration.nix /mnt/home/hio/dotfiles/

# 3. Add hardware config to git & install
cd /mnt/home/hio/dotfiles
git add hardware-configuration.nix
nixos-install --flake .#nixbtw

# 4. Set password and reboot
passwd hio
reboot
```
