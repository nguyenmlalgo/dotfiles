#!/bin/bash

# Script to clean up an Arch Linux system.

echo ":: Cleaning up orphaned packages..."
if [[ -n $(pacman -Qtdq) ]]; then
    sudo pacman -Rns $(pacman -Qtdq)
else
    echo "No orphaned packages to remove."
fi
echo

echo ":: Cleaning up pacman cache (keeping 3 versions)..."
sudo paccache -r
echo

if command -v yay &> /dev/null
then
    echo ":: Cleaning up yay cache..."
    yay -Yc
    echo
else
    echo ":: yay not found. Skipping AUR cache cleanup."
fi

echo ":: Cleaning up systemd journal (keeping 100MB)..."
sudo journalctl --vacuum-size=100M
echo

echo ":: Cleaning trash folder..."
sudo rm -rf ~/.local/share/Trash/info/
sudo rm -rf ~/.local/share/Trash/files/
echo

echo "CLEANUP PROCESS COMPLETE!"
