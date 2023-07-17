#!/bin/bash

# define your menu options
OPTIONS=(
"S Spotify" 
"i Signal" 
"O Obsidian"
)

# launch rofi with the options
LAUNCHER="rofi -dmenu -i -p flatpak"

# get the user's choice
CHOICE=$(printf '%s\n' "${OPTIONS[@]}" | $LAUNCHER | awk '{print $1}')

# run the selected app
case "$CHOICE" in
    S) flatpak run com.spotify.Client ;;
    i) flatpak run org.signal.Signal ;;
    O) flatpak run md.obsidian.Obsidian ;;
esac
