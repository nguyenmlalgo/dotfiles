#!/usr/bin/env bash

notify() {
    dunstify -u low -i network-wireless "$1"
}

signal_bars() {
    local strength=$1
    if   [ "$strength" -ge 80 ]; then echo "█"
    elif [ "$strength" -ge 60 ]; then echo "▆"
    elif [ "$strength" -ge 40 ]; then echo "▄"
    else echo "▂"
    fi
}

menu() {
    echo "  Rescan"
    echo "  Disconnect"
    echo "  Toggle Wi-Fi"

    active_ssid=$(nmcli -t -f ACTIVE,SSID dev wifi | grep "^yes" | cut -d: -f2)

    nmcli -t -f SSID,SIGNAL,SECURITY dev wifi list | while IFS=: read -r ssid signal security; do
        [ -z "$ssid" ] && continue
        bars=$(signal_bars "$signal")

        if [ "$ssid" = "$active_ssid" ]; then
            printf " %s | %s%% %s | %s\n" "$ssid" "$signal" "$bars" "$security"
        else
            printf "   %s | %s%% %s | %s\n" "$ssid" "$signal" "$bars" "$security"
        fi
    done
}

connect_with_password() {
    local ssid="$1"
    while true; do
        pass=$(rofi -dmenu -password -p "🔑 Enter password for $ssid (Esc=back)")
        if [ -z "$pass" ]; then
            # User pressed Esc or empty → back to Wi-Fi menu
            exec "$0"
        fi

        # Delete old profile only if we have a new password
        nmcli con delete "$ssid" 2>/dev/null

        if nmcli dev wifi connect "$ssid" password "$pass" >/dev/null 2>&1; then
            ip=$(nmcli -t -f IP4.ADDRESS dev show | grep -m1 "IP4.ADDRESS" | cut -d: -f2)
            notify "Connected to $ssid (IP $ip)"
            break
        else
            notify "Wrong password for $ssid, try again or press Esc to choose another Wi-Fi"
        fi
    done
}


chosen=$(menu | rofi -dmenu -i -p "Wi-Fi")
[ -z "$chosen" ] && exit

case "$chosen" in
    "  Rescan")
        nmcli dev wifi rescan
        notify "Wi-Fi networks rescanned"
        exec "$0" ;;

    "  Disconnect")
        active=$(nmcli -t -f NAME con show --active | head -n1)
        if [ -n "$active" ]; then
            nmcli con down id "$active" && notify "Disconnected from $active"
        else
            notify "No active Wi-Fi connection"
        fi
        exit ;;

    "  Toggle Wi-Fi")
        state=$(nmcli radio wifi)
        if [ "$state" = "enabled" ]; then
            nmcli radio wifi off && notify "Wi-Fi disabled"
        else
            nmcli radio wifi on && notify "Wi-Fi enabled"
        fi
        exit ;;

    *)
        ssid=$(echo "$chosen" | awk -F'|' '{print $1}' | sed 's/^ //;s/^ *//;s/ *$//')
        security=$(echo "$chosen" | awk -F'|' '{print $3}' | xargs)

        if nmcli -t -f NAME con show | grep -qx "$ssid"; then
            if nmcli con up "$ssid"; then
                ip=$(nmcli -t -f IP4.ADDRESS dev show | grep -m1 "IP4.ADDRESS" | cut -d: -f2)
                signal=$(nmcli -t -f IN-USE,SIGNAL dev wifi | grep "^\*" | cut -d: -f2)
                notify "Connected to $ssid (${signal}% signal, IP $ip)"
            else
                notify "Failed to connect $ssid — maybe password changed"
                nmcli con delete "$ssid"
                connect_with_password "$ssid"
            fi
        else
            if [ "$security" = "--" ] || [ "$security" = "" ]; then
                if nmcli dev wifi connect "$ssid"; then
                    ip=$(nmcli -t -f IP4.ADDRESS dev show | grep -m1 "IP4.ADDRESS" | cut -d: -f2)
                    notify "Connected to $ssid (open network, IP $ip)"
                else
                    notify "Could not connect to $ssid"
                fi
            else
                connect_with_password "$ssid"
            fi
        fi
        ;;
esac
