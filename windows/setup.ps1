echo "Running windows setup:"

echo "Running ninite:"
./windows/ninite-7zip-chrome-discord-spotify-steam-vlc-zoom.exe
echo "Finished running ninite."

./windows/remove-bloatware.ps1

./windows/disable-hibernation.ps1

./windows/wsl-prereqs.ps1

echo "Finished windows setup!"
