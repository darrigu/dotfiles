#!/usr/bin/env bash

POWER_ON=$(grep 'green' < "$HOME/.config/polybar/colors.ini" | head -n1 | cut -d '=' -f2 | tr -d ' ')
POWER_OFF=$(grep 'alt_foreground' < "$HOME/.config/polybar/colors.ini" | head -n1 | cut -d '=' -f2 | tr -d ' ')

power_on() {
    if bluetoothctl show | grep -q "Powered: yes"; then
        return 0
    else
        return 1
    fi
}

device_connected() {
    device_info=$(bluetoothctl info "$1")
    if echo "$device_info" | grep -q "Connected: yes"; then
        return 0
    else
        return 1
    fi
}

print_status() {
    if power_on; then
        if [[ -z $(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-) ]]; then
            echo "%{F$POWER_ON}%{T2}%{T-} %{F-}Power: on"
        fi

        paired_devices_cmd="devices Paired"
        bt_version=$(bluetoothctl version 2>/dev/null | awk '{print $2}' | head -n1)
        if [ -n "$bt_version" ] && echo "$bt_version < 5.65" | bc -l 2>/dev/null | grep -q 1; then
            paired_devices_cmd="paired-devices"
        else
            paired_devices_cmd="devices Paired"
        fi

        mapfile -t paired_devices < <(bluetoothctl $paired_devices_cmd | grep Device | cut -d ' ' -f 2)
        counter=0
        icons=""

        for device in "${paired_devices[@]}"; do
            if device_connected "$device"; then
                device_alias=$(bluetoothctl info "$device" | grep "Alias" | cut -d ' ' -f 2-)
                device_type=$(bluetoothctl info "$device" | grep "Icon" | cut -d ' ' -f 2-)

                case $device_type in
                    "input-mouse")
                        icons="$icons | 󰍽"
                        ;;
                    "audio-headset")
                        icons="$icons | 󰋎"
                        ;;
                    "audio-headphones")
                        icons="$icons | "
                        ;;
                    "audio-card" | "audio-speaker")
                        icons="$icons | 󰓃"
                        ;;
                    "input-keyboard")
                        icons="$icons | 󰌌"
                        ;;
                    "input-gaming")
                        icons="$icons | 󰖺"
                        ;;
                    "phone")
                        icons="$icons | "
                        ;;
                    *)
                        icons="$icons | $device_type"
                esac
                ((counter++))
            fi
        done
        icons=$(echo "$icons" | cut -c3-)

        if [[ $counter -gt 1 ]]; then
            echo "%{F$POWER_ON}%{T2}%{T-} %{F-}$icons"
        elif [[ $counter -gt 0 ]]; then
            echo "%{F$POWER_ON}%{T2}%{T-} %{F-}$icons | $device_alias"
        fi
    else
        echo "%{F$POWER_OFF}%{T2}%{T-} Power: off%{F-}"
    fi
}

print_status
