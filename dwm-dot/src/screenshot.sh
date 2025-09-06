#!/usr/bin/env bash

dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="Screenshot_$(date +%Y-%m-%d-%H%M%S).png"

case "$1" in
    full)
        maim "$dir/$file"
        xclip -selection clipboard -t image/png -i "$dir/$file"
        notify-send "📸 Screenshot" "Full screen copied to clipboard and saved to $file"
        ;;
    area)
        maim -s "$dir/$file"
        xclip -selection clipboard -t image/png -i "$dir/$file"
        notify-send "📸 Screenshot" "Selected area copied to clipboard and saved to $file"
        ;;
esac
