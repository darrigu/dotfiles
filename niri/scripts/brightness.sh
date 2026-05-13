#!/usr/bin/env bash

cur=$(brightnessctl g)
max=$(brightnessctl m)
brightness=$(( (cur * 100 + max / 2) / max ))

notify-send -t 1000 -a brightness -h string:x-canonical-private-synchronous:brightness -h int:value:$brightness "Brightness: ${brightness}%"
