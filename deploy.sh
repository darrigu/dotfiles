#!/usr/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"

symlinkFile() {
   src="$SCRIPT_DIR/$1"
   dest="$HOME/$2/$1"

   mkdir -p $(dirname "$dest")

   if [ -L "$dest" ]; then
      echo "[WARNING] $src already symlinked"
      return
   fi

   if [ -e "$dest" ]; then
      echo "[ERROR] $dest exists but it's not a symlink. Please fix that manually"
      exit 1
   fi

   ln -s "$src" "$dest"
   echo "[OK] $src -> $dest"
}

deployManifest() {
   for row in $(cat $SCRIPT_DIR/$1); do
      if [[ "$row" =~ ^#.* ]]; then
         continue
      fi

      src=$(echo $row | cut -d \| -f 1)
      op=$(echo $row | cut -d \| -f 2)
      dest=$(echo $row | cut -d \| -f 3)

      case $op in
         symlink)
            symlinkFile $src $dest
            ;;

         *)
            echo "[WARNING] Unknown operation $op. Skipping..."
            ;;
      esac
   done
}

if [ -z "$@" ]; then
   echo "Usage: $0 <MANIFEST>"
   echo "ERROR: no MANIFEST file is provided"
   exit 1
fi

deployManifest $1
