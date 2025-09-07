#!/bin/bash

# Script to update an Arch Linux system using pacman and yay.
# ADVICE: It is recommended to run this script interactively to review package changes.

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Update official repositories (pacman) ---
echo "##################################################"
echo "##                                              ##"
echo "##  Updating official packages with pacman...   ##"
echo "##                                              ##"
echo "##################################################"
sudo pacman -Syu

echo
echo "Pacman update complete."
echo

# --- Update AUR packages (yay) ---
# Check if yay is installed before attempting to use it
if command -v yay &> /dev/null
then
    echo "##################################################"
    echo "##                                              ##"
    echo "##      Updating AUR packages with yay...       ##"
    echo "##                                              ##"
    echo "##################################################"
    yay -Sua
    echo
    echo "Yay update complete."
else
    echo ":: yay is not installed. Skipping AUR update."
fi

echo
echo "##################################################"
echo "##                                              ##"
echo "##           UPDATE PROCESS COMPLETE!           ##"
echo "##                                              ##"
echo "##################################################"
