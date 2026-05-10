#!/bin/sh

STEP=5

case "$1" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%+ -l 1.5
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')

if wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED; then
    dunstify -r 9991 -h int:value:0 "Volume" "Muted"
else
    dunstify -r 9991 -h int:value:$VOL "Volume" "$VOL%"
fi
