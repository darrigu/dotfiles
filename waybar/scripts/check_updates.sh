#!/usr/bin/env bash

pad() { local s="$1" len="${2:-20}"; (( ${#s} > len )) && echo "${s:0:$((len-2))}.." || printf "%-${len}s" "$s"; }

mapfile -t updates < <(
  apk upgrade -s 2>/dev/null \
    | awk '/Upgrading/ { gsub(/[()]/, ""); print $3, $4, $6 }'
)

count=${#updates[@]}

if (( count == 0 )); then
  echo '{"text":"","tooltip":"System is up to date"}'
  exit 0
fi

tooltip="<b>$count updates</b>\n"
tooltip+="<b>$(pad "Package" 20) $(pad "Current" 15) $(pad "Available" 15)</b>\n"

for line in "${updates[@]}"; do
  read -r name old new <<< "$line"
  tooltip+="<b>$(pad "$name" 20)</b> $(pad "$old" 15) $(pad "$new" 15)\n"
done

printf '{"text":"󰦘","tooltip":"%s"}\n' "${tooltip%\\n}"
