#!/bin/sh

STEP=5

CURRENT=$(brightnessctl get)
MAX=$(brightnessctl max)

PERCENT=$(((CURRENT*100 + MAX/2)/MAX))
PERCENT=$(((PERCENT/STEP)*STEP))

case "$1" in
    up)
        NEW=$((PERCENT + STEP))
        [ "$NEW" -gt 100 ] && NEW=100
        ;;
    down)
        NEW=$(( PERCENT - STEP ))
        [ "$NEW" -lt 0 ] && NEW=0
        ;;
esac

brightnessctl set "${NEW}%"

dunstify -r 9992 -h int:value:$NEW "Brightness" "${NEW}%"
