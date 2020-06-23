# dotfiles

[![Build Status](https://travis-ci.org/suitupalex/dotfiles.svg?branch=master)](https://travis-ci.org/suitupalex/dotfiles)

My personal dotfiles.

## BIOS

1. Enable D.O.C.P.
1. Enable Virtualization
1. Adjust CPU Fan Curves

## Windows

1. Install Windows 10 N
1. Disable all data collection
1. Disable Cortana
1. Disable UAC
1. Download and install Windows 10 updates
1. Run Ninite: `./windows/ninite-*.exe`
1. Update all motherboard drivers
1. Update graphics card drivers and settings
    * [GeForce Experience](https://www.nvidia.com/en-us/geforce/geforce-experience/)
    * Power management mode: `Prefer maximum performance`
    * Texture filtering - Quality: `High performance`
1. Install utilities:
    * [GPU-Z](https://www.techpowerup.com/download/techpowerup-gpu-z/)
    * [HWMonitor](https://www.cpuid.com/softwares/hwmonitor.html)
    * [Slack](https://slack.com/downloads/windows)
    * [WSLtty](https://github.com/mintty/wsltty/releases)
1. Enable WSL
    ```
    > dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    ```
1. Enable Virtual Machine Platform component
    ```
    > dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    ```
1. Run `./windows/wsl_update_x64.msi`
1. Set WSL 2 as default
    ```
    > wsl --set-default-version 2
    ```
1. Install `Ubuntu` from Microsoft Store

## WSL Init
Compatible with Ubuntu v20.04+

```
> sudo --preserve-env=HOME USER=$USER ./apt-init-wsl
```
