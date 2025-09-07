#!/bin/sh

# Lấy âm lượng hiện tại
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | sed 's/%//')

# Giá trị tối đa âm lượng
max_volume=166

# Tính toán phần trăm âm lượng
percentage=$(( 100 * volume / max_volume ))

# Hiển thị âm lượng theo định dạng phần trăm
echo "${percentage}%"
