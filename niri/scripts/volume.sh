#!/usr/bin/env bash

volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if [[ "$volume" == *"[MUTED]" ]]; then
  text="Muted"
else
  text="Volume:"
fi

volume=$(echo "$volume" | awk '{print $2}')
volume=$(echo "($volume*100)/1" | bc)

notify-send -t 1000 -a volume -h string:x-canonical-private-synchronous:volume -h int:value:$volume "$text ${volume}%"

