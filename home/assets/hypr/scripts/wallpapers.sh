#!/usr/bin/env bash

WALLPAPER_DIR="${HOME}/wallpapers"
TRANSITION_TYPE="grow"
TRANSITION_DURATION="0.25"

# ensure swww is running
swww-daemon &>/dev/null

readarray -t WALLPAPERS < <(find "${WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print | sed "s|^${WALLPAPER_DIR}/||" | sort)
SELECTED_WALLPAPER_BASENAME=$(printf "%s\n" "${WALLPAPERS[@]}" | wofi --dmenu --prompt "Select Wallpaper")

if [ -n "$SELECTED_WALLPAPER_BASENAME" ]; then
    FULL_WALLPAPER_PATH="${WALLPAPER_DIR}/${SELECTED_WALLPAPER_BASENAME}"
    if [ -f "$FULL_WALLPAPER_PATH" ]; then
        swww img "$FULL_WALLPAPER_PATH" \
            --transition-type "$TRANSITION_TYPE" \
            --transition-duration "$TRANSITION_DURATION"
    else
        notify-send "Wallpaper Error" "Selected wallpaper not found: $FULL_WALLPAPER_PATH"
    fi
fi