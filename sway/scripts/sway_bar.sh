#!/usr/bin/env bash

printf -v datetime "%(%d/%m/%Y %H:%M)T" -1

battery_info=$(upower --show-info "$(upower --enumerate | grep BAT)" 2>/dev/null)
battery_charge=${battery_info#*percentage:}
battery_charge=${battery_charge%%%*}
battery_charge=${battery_charge// }
battery_state=${battery_info#*state:}
battery_state=${battery_state%%$'\n'*}
battery_state=${battery_state// }

case "$battery_state" in
   "charging") battery_icon="(c)" ;;
   "discharging") battery_icon="(d)" ;;
   "fully-charged") battery_icon="(f)" ;;
   *) battery_icon="(?)" ;;
esac

audio_info=$(pamixer --get-volume --get-mute 2>/dev/null)
if [[ $? -eq 0 ]]; then
   audio_volume=${audio_info#*$' '}
   muted=${audio_info%$' '*}
   [[ "$muted" == "true" ]] && audio_icon="MUTED" || audio_icon="$audio_volume%"
else
   audio_icon="?"
fi

get_network_status() {
    if ! nmcli -t -f RUNNING general 2>/dev/null | grep -q '^running$'; then
        echo "OFFLINE"
        return
    fi

    local connection
    connection=$(nmcli -t -f DEVICE,STATE,CONNECTION device status 2>/dev/null | \
        awk -F: '$2 == "connected" {print $1 " " $3; exit}')

    [[ -z "$connection" ]] && { echo "OFFLINE"; return; }

    local iface=${connection% *} conn_name=${connection#* }

    if [[ "$iface" == wl* ]]; then
        local ssid
        ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | \
            awk -F: '$1 == "yes" {print $2; exit}')
        echo "${ssid:-WIFI}"
    else
        echo "$conn_name"
    fi
}

network_status=$(get_network_status)

window_title=$(
  swaymsg -t get_tree | jq -r '
    recurse(.nodes[]?, .floating_nodes[]?) |
    select(.focused == true) |
    .name // empty
  '
)

term_width=$(tput cols)
left_content="$window_title"
right_content="$network_status | $audio_icon | $battery_charge% $battery_icon | $datetime"

printf "%-*s%s\n" $((term_width - ${#right_content})) "$left_content" "$right_content"
