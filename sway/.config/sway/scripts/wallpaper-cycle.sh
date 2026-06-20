#!/bin/bash
WALLPAPER_DIR="$HOME/.config/wallpapers"
STATE_FILE="/tmp/wallpaper-index"

mapfile -t walls < <(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' \) | sort)

[[ ${#walls[@]} -eq 0 ]] && exit 1

idx=0
[[ -f "$STATE_FILE" ]] && idx=$(<"$STATE_FILE")
idx=$(( (idx + 1) % ${#walls[@]} ))
echo "$idx" > "$STATE_FILE"

swaymsg output '*' bg "${walls[$idx]}" fill
notify-send -t 2000 "Wallpaper" "$(basename "${walls[$idx]}")"
