# dotfiles

[![Build Status](https://travis-ci.org/suitupalex/dotfiles.svg?branch=master)](https://travis-ci.org/suitupalex/dotfiles)

My personal dotfiles.

## BIOS

1. Enable D.O.C.P.
1. Enable Virtualization
1. Adjust CPU Fan Curves

## Windows

1. Install Windows 10
1. Disable all data collection
1. Disable Cortana
1. Disable UAC
1. Download and install Windows 10 updates
1. Update Powershell execution policy
    * Run Powershell as administrator
    ```
    > Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
    ```
1. Run `./windows/setup.ps1` (usually requires restart)
1. Update all motherboard drivers
1. Update graphics card drivers and settings
    * [GeForce Experience](https://www.nvidia.com/en-us/geforce/geforce-experience/)
    * Power management mode: `Prefer maximum performance`
    * Texture filtering - Quality: `High performance`
    * Disable In-Game Overlay
    * Disable `Reward is available` desktop notification
    * Enable `Automatically download driver updates...`
1. Update monitor refresh rate
1. Install `Ubuntu` from Microsoft Store
1. Install utilities:
    * [GPU-Z](https://www.techpowerup.com/download/techpowerup-gpu-z/)
    * [HWMonitor](https://www.cpuid.com/softwares/hwmonitor.html)
    * [Slack](https://slack.com/downloads/windows)
    * [WSLtty](https://github.com/mintty/wsltty/releases)
1. Set WSLtty shortcut to always run as administrator
    * Search `WSL Terminal` in start menu
    * Open file location
    * Right click -> Properties -> Compatibility -> Run this program as administrator
1. Set power plan to High Performance (AMD Ryzen specific if applicable)
1. Disable extraneous audio devices

## WSL Init
Compatible with Ubuntu v20.04+

```
> sudo --preserve-env=HOME USER=$USER ./apt-init-wsl
```
