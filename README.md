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
    * `chezmoi init` asks for your name, email, and whether this is the home server
    * Installs apps with winget from `home/.chezmoidata/packages.yaml`: `winget` on every machine,
      `winget_desktop` (drivers, services, large installers) everywhere except CI, and `winget_server`
      (L-Connect 3, NZXT CAM, Sunshine) only if you answer yes to the home server prompt
    * Removes bloatware (`packages.appx_remove`) and disables Xbox Game Bar
    * Disables hibernation and sets the high performance power plan
    * Disables the OneDrive sync client with a policy
    * Installs Vim from winget (9.2) with the same config as Linux (`~/_vimrc` and `~/vimfiles`)
    * Sets up the PowerShell 7 profile (`~/.config/powershell/profile.ps1`, loaded through a stub at your real `$PROFILE`):
      history suggestions, `eza` for `ls`, `zoxide`, fzf key bindings (PSFzf), a starship prompt, and the `dev`, `p`, `g` shortcuts
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

This installs the apt packages, [mise](https://mise.jdx.dev) tools (node, go, kubectl, helm, gh, trufflehog, fzf, fd, bat, eza, zoxide),
the fish and tmux plugins, the Vim plugins (native packages, pinned by commit), and sets fish as the login shell.
Vim itself comes from apt, so it is Ubuntu's version (9.1); Windows gets the newer one from winget.

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
| `home/.chezmoidata/packages.yaml` | apt packages, winget apps (core, desktop, server), startup entries to disable, and Appx packages to remove |
| `home/.chezmoiexternal.toml.tmpl` | pinned mise binary, Vundle, and tpm |
| `home/run_*` | install scripts for Linux (`.sh`) and Windows (`.ps1`) |
| `home/Scripts/` | Windows-only scripts: Chrome border watcher and AutoHotkey hotkeys |
| `home/dot_config/mise/config.toml` | global tool versions |
| `home/.chezmoitemplates/vimrc` | the vimrc for both OSes (`~/.vimrc` on Linux, `~/_vimrc` on Windows); plugins are pinned in `home/.chezmoidata/vim.yaml` |
| `home/dot_config/powershell/profile.ps1` | shared PowerShell 7 profile, with a starship prompt config in `home/dot_config/starship.toml` |
| `scripts/audit-packages.*` | lists installed packages that aren't in `packages.yaml`, and the reverse (see below) |
| `windows/wsl-firewall.ps1` | forwards WSL ports, used by the `fw` alias |
| `fonts/` | `Source Code Pro`, installed by the Windows scripts |

## Auditing packages

chezmoi only knows the lists in `packages.yaml`, so these scripts compare them with what is installed:

```
> ./scripts/audit-packages.sh      # Ubuntu (WSL): manual apt packages
> ./scripts/audit-packages.ps1     # Windows: winget packages
```

Each prints packages that are installed but not tracked, and tracked packages that are missing.
Runtimes and system packages are skipped through `packages.audit_ignore`.
`chezmoi unmanaged <dir>` does the same for files.

## Backups

Settings that live inside an app (for example FrankerFaceZ in Chrome) can be exported into
`backups/`. The repo is public, so `.gitignore` blocks everything in `backups/` except files that
were reviewed for secrets and approved by name (currently `ffz-settings.json`). If a future export
does contain secrets, encrypt it with [age](https://github.com/FiloSottile/age) and not with this
allow list; age isn't installed by this repo because nothing needs it today.

For FrankerFaceZ: twitch.tv, FFZ Control Center, Data Management, Backup and Restore. Restoring
is manual, through the same screen: choose `backups/ffz-settings.json` there. To refresh the
backup, export again and overwrite the file.

## Secret scanning

CI scans the full git history with [TruffleHog](https://github.com/trufflesecurity/trufflehog) (free, AGPL-3.0)
and fails on verified or unverifiable secrets. To scan locally (mise installs `trufflehog`):

```
> trufflehog git file://. --no-update --no-verification
```

## Maintenance

* **mise:** the binary is pinned in `home/.chezmoiexternal.toml.tmpl`. To bump it, update
  the version and the sha256 checksums from the release's `SHASUMS256.txt`.
* **Vim plugins:** pinned by commit in `home/.chezmoidata/vim.yaml`. To update one, change its commit; chezmoi downloads it and regenerates the help tags.
* **fisher:** pinned by version and sha256 in `home/run_onchange_after_30-plugins.sh.tmpl`.
* **chezmoi in CI:** pinned by version and sha256 in `.github/workflows/ci.yml`.
* **Actions:** pinned by commit SHA, updated weekly by Dependabot.

CI applies the dotfiles on clean Ubuntu and Windows runners (skipping the desktop and server
winget lists), runs a smoke test, and checks that a second apply changes nothing. It also runs weekly to catch upstream breakage.

A job only runs when the change could affect it (`scripts/ci-changes.sh`): a README or backup
change runs only the secret scan, a fish change skips the Windows job, and a PowerShell change
skips the Linux job. Anything the script doesn't recognise, and every scheduled or manual run,
runs everything. A PR is compared with `main`, so each push re-runs whatever the PR as a whole touches.
