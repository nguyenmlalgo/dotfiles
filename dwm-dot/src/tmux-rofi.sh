#!/usr/bin/env bash

# Lấy terminal mặc định từ biến môi trường, fallback sang kitty
term="${TERMINAL:-kitty}"

while true; do
    # Lấy danh sách tmux sessions
    sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)

    # Menu chính
    main_choice=$(printf "➕ New session\n📂 Attach session\n❌ Delete session\n✏️ Rename session\n🚪 Exit" | rofi -dmenu -p "tmux:")

    [ -z "$main_choice" ] && exit 0

    case "$main_choice" in
        "➕ New session")
            new_name=$(rofi -dmenu -p "New tmux session name:")
            if [ -z "$new_name" ]; then
                continue
            fi
            exec $term -e tmux new-session -s "$new_name"
            ;;

        "📂 Attach session")
            if [ -z "$sessions" ]; then
                notify-send "tmux" "No sessions to attach"
                continue
            fi
            choice=$(echo -e "⬅️ Back\n$sessions" | rofi -dmenu -p "Attach session:")
            [ -z "$choice" ] && continue
            [ "$choice" = "⬅️ Back" ] && continue
            exec $term -e tmux attach-session -t "$choice"
            ;;

        "❌ Delete session")
            while true; do
                sessions=$(tmux list-sessions -F "#{session_name}" 2>/dev/null)
                if [ -z "$sessions" ]; then
                    notify-send "tmux" "No sessions to delete"
                    break
                fi
                choice=$(echo -e "⬅️ Back\n$sessions" | rofi -dmenu -p "Delete session:")
                [ -z "$choice" ] && break
                [ "$choice" = "⬅️ Back" ] && break
                tmux kill-session -t "$choice"
                notify-send "tmux" "Deleted session: $choice"
            done
            ;;

        "✏️ Rename session")
            if [ -z "$sessions" ]; then
                notify-send "tmux" "No sessions to rename"
                continue
            fi
            old_name=$(echo -e "⬅️ Back\n$sessions" | rofi -dmenu -p "Select session to rename:")
            [ -z "$old_name" ] && continue
            [ "$old_name" = "⬅️ Back" ] && continue
            new_name=$(rofi -dmenu -p "New name for $old_name:")
            [ -z "$new_name" ] && continue
            tmux rename-session -t "$old_name" "$new_name"
            notify-send "tmux" "Renamed '$old_name' → '$new_name'"
            ;;

        "🚪 Exit")
            exit 0
            ;;
    esac
done
