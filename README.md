# dotfiles

[![CI](https://github.com/umamialex/dotfiles/actions/workflows/ci.yml/badge.svg)](https://github.com/umamialex/dotfiles/actions/workflows/ci.yml)

My personal dotfiles, managed with [chezmoi](https://www.chezmoi.io) and [mise](https://mise.jdx.dev).

## Setup

### 1. BIOS

1. Enable D.O.C.P.
1. Enable Virtualization
1. Adjust CPU Fan Curves

### 2. Windows

1. Install Windows
1. Disable all data collection
1. Disable Cortana
1. Disable UAC
1. Download and install Windows updates
1. Install PowerShell 7 and chezmoi
    ```
    > winget install Microsoft.PowerShell
    > winget install twpayne.chezmoi
    ```
1. Apply the dotfiles (usually requires restart)
    * Open a new `PowerShell 7` terminal as administrator, so it picks up the new PATH
    ```
    > chezmoi init --apply umamialex
    ```
    * Installs apps with winget (see `packages.winget` in `home/.chezmoidata/packages.yaml`)
    * Removes bloatware (`packages.appx_remove`) and disables Xbox Game Bar
    * Disables hibernation and sets the high performance power plan
    * Disables Multiplane Overlay on NVIDIA GPUs (fixes Chrome freezing with several video streams, needs a restart)
    * Keeps Chrome windows on black, square borders with a logon task (`~/Scripts/Set-ChromeBorder.ps1`)
    * Installs AutoHotkey v2 and starts `~/Scripts/AutoHotkey/multimedia-control.ahk` at sign-in
    * Disables the startup entries listed in `packages.startup_disable` that exist on the machine
    * Installs WSL 2, Ubuntu, and the `Source Code Pro` font
    * `.ps1` scripts run with `pwsh -ExecutionPolicy Bypass`, so no execution policy change is needed
1. Update all motherboard drivers
1. Update graphics card drivers and settings
    * [GeForce Experience](https://www.nvidia.com/en-us/geforce/geforce-experience/)
    * Power management mode: `Prefer maximum performance`
    * Texture filtering - Quality: `High performance`
    * Disable In-Game Overlay
    * Disable `Reward is available` desktop notification
    * Enable `Automatically download driver updates...`
1. Update monitor refresh rate
1. Launch Chrome with `--disable-features=UseEcoQoSForBackgroundProcess,CalculateNativeWinOcclusion`
    (add it to the shortcut target as a single comma-separated flag) and turn off
    `Continue running background apps when Google Chrome is closed`
1. Install the vendor apps winget does not carry: Adobe apps (through Creative Cloud), ASUS Armoury Crate and Aura,
    the GoXLR app and driver, MOZA Pit House, SimHub, Samsung Magician and the AMD chipset driver
1. Set the Windows Terminal font to `Source Code Pro` and set to medium weight
1. Disable extraneous audio devices

### 3. Ubuntu (WSL)

Open Ubuntu, then:

```
> sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply umamialex
```

This installs the apt packages, [mise](https://mise.jdx.dev) tools (node, go, kubectl, helm),
the fish/vim/tmux plugins, and sets fish as the login shell.

## Day to day

```
> chezmoi edit ~/.vimrc   # edit the source for a file
> chezmoi diff            # see what apply would change
> chezmoi apply           # apply the source state to ~
> chezmoi update          # pull the latest from GitHub and apply
```

Scripts named `run_onchange_*` re-run only when the data they depend on changes,
and `run_once_*` scripts run once per machine.

## Layout

| Path | Purpose |
|---|---|
| `home/` | chezmoi source directory (`.chezmoiroot`) |
| `home/.chezmoidata/packages.yaml` | apt packages, winget apps, and Appx packages to remove |
| `home/.chezmoiexternal.toml.tmpl` | pinned mise binary, Vundle, and tpm |
| `home/run_*` | install scripts for Linux (`.sh`) and Windows (`.ps1`) |
| `home/Scripts/` | Windows-only scripts: Chrome border watcher and AutoHotkey hotkeys |
| `home/dot_config/mise/config.toml` | global tool versions |
| `windows/wsl-firewall.ps1` | forwards WSL ports, used by the `fw` alias |
| `fonts/` | `Source Code Pro`, installed by the Windows scripts |

## Maintenance

* **mise:** the binary is pinned in `home/.chezmoiexternal.toml.tmpl`. To bump it, update
  the version and the sha256 checksums from the release's `SHASUMS256.txt`.
* **fisher:** pinned by version and sha256 in `home/run_onchange_after_30-plugins.sh.tmpl`.
* **chezmoi in CI:** pinned by version and sha256 in `.github/workflows/ci.yml`.
* **Actions:** pinned by commit SHA, updated weekly by Dependabot.

CI applies the dotfiles on clean Ubuntu and Windows runners, runs a smoke test, and checks
that a second apply changes nothing. It also runs weekly to catch upstream breakage.
