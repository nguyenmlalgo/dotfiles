#!/bin/bash

# Điều chỉnh độ sáng theo tham số đầu vào (up hoặc down)
case "$1" in
  up)
    brightnessctl set +10%
    ;;
  down)
    brightnessctl set 10%-
    ;;
esac

# Lấy phần trăm độ sáng hiện tại
brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
brightness_percent=$(( 100 * brightness / max_brightness ))

# Hiển thị thông báo
dunstify -a "brightness" -u low -h string:x-dunst-stack-tag:brightness "☀️ Brightness: $brightness_percent%"
