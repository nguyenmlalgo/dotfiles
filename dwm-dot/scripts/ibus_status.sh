#!/bin/sh

# Lấy tên của input method đang sử dụng
current_method=$(ibus engine)

# Kiểm tra phương pháp nhập liệu và gán ký hiệu tương ứng
case "$current_method" in
    "Bamboo::Flag")
        echo "[VN]"
        ;;
    "BambooUs::Flag")
        echo "[EN]"
        ;;
    *)
        echo "Unknown"
        ;;
esac

