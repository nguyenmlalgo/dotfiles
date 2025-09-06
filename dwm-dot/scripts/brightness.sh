#!/bin/sh
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percentage=$((100 * brightness / max_brightness))
echo "${percentage}%"
