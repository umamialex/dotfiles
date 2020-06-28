echo "Running WSL prereqs:"

echo "Enabling WSL:"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
echo "Finished enabling WSL."

echo "Enabling VMs:"
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
echo "Finished enabling VMs."

echo "Downloading WSL2 Update:"
$progressPreference = 'silentlyContinue'
Invoke-WebRequest "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "C:\wsl_update_x64.msi"
$progressPreference = 'Continue'
echo "Finished downloading WSL2 Update."

echo "Run WSL2 Kernel Update:"
msiexec.exe /I "C:\wsl_update_x64.msi" /quiet
Remove-Item "C:\wsl_update_x64.msi"
echo "Finished running WSL2 Kernel Update."

echo "Setting WSL 2 as default:"
wsl --set-default-version 2
echo "Finished settings WSL2 as default."

echo "Finished running WSL prereqs."


