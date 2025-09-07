#!/bin/bash

# Điều chỉnh âm lượng theo tham số đầu vào (up, down hoặc mute)
case "$1" in
  up)
    pactl set-sink-volume @DEFAULT_SINK@ +5%
    ;;
  down)
    pactl set-sink-volume @DEFAULT_SINK@ -5%
    ;;
  mute)
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    ;;
esac

# Lấy phần trăm âm lượng hiện tại và trạng thái mute
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1)
mute_status=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o 'yes\|no')

# Kiểm tra trạng thái mute và hiển thị thông báo phù hợp
if [ "$mute_status" == "no" ]; then
  dunstify -a "volume" -u low -h string:x-dunst-stack-tag:volume "🔊 Volume: $volume"
else
  dunstify -a "volume" -u low -h string:x-dunst-stack-tag:volume "🔇 Muted"
fi
