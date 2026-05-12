#!/usr/bin/env bash

tooltip="<b>Daemon -> Mako</b>\nOn Click Cycle DND's"
state="$(makoctl mode | tr '\n' ' ')"

toggle() {
  case "$state" in
  "default silent ")
    makoctl mode -a "do-not-disturb"
    ;;
  *"disturb"*)
    makoctl mode -r "silent" -r "do-not-disturb"
    ;;
  *)
    makoctl mode -a "silent"
    ;;
esac
}

if [ $# -eq 1 ]; then
  case "$state" in
  "default silent ")
    cat <<EOF
{"text":"","tooltip":"$tooltip\n<b>State<\/b>: Silent"}
EOF
    ;;
  *"disturb"*)
    cat <<EOF
{"text":"","tooltip":"$tooltip\n<b>State<\/b>: DND"}
EOF
    ;;
  *)
    cat <<EOF
{"text":"󰂞","tooltip":"$tooltip\n<b>State:<\/b> Notification"}
EOF
    ;;
  esac
else
  toggle &>/dev/null
  pkill -SIGRTMIN+2 waybar
fi
