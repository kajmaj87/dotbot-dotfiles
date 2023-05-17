#!/bin/bash

# Get metadata from Spotify using D-Bus and MPRIS
metadata=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2>/dev/null)

if [ -z "$metadata" ]; then
    # echo "No track"
    exit
fi

# Extract artist and track title
#artist=$(echo "$metadata" | sed -n '/xesam:artist/{n;n;p}' | sed 's/^\s*string\s*"\(.*\)"\s*$/\1/')
#title=$(echo "$metadata" | sed -n '/xesam:title/{n;p}' | sed 's/^\s*string\s*"\(.*\)"\s*$/\1/')

#artist=$(echo "$metadata" | grep -A1 "xesam:artist" | grep "string" | cut -d '"' -f2)
#title=$(echo "$metadata" | grep "xesam:title" | cut -d '"' -f2)

#artist=$(echo "$metadata" | awk -F '"' '/xesam:artist/{getline; getline; print}')
#title=$(echo "$metadata" | awk -F '"' '/xesam:title/{getline; print}')

artist=$(echo "$metadata" | grep -A2 "xesam:artist" | tail -n1 | cut -d '"' -f2)
title=$(echo "$metadata" | grep -A1 "xesam:title" | tail -n1 | cut -d '"' -f2)

# Display the result
echo "$artist - $title"
