#!/bin/bash

# Define the device MAC address for your Jabra headset
DEVICE_MAC="70:BF:92:38:3B:99"  # Replace with your Jabra's MAC address

# Check if the device is connected
CONNECTED=$(bluetoothctl info $DEVICE_MAC | grep "Connected: yes")

# Define the icons for headset, headset with microphone, and disconnected headset
ICON_HEADSET="🎧"
ICON_HEADSET_MIC="🎤"
ICON_DISCONNECTED="❌"
ICON_FALLBACK="❓"

if [[ -z $CONNECTED ]]; then
    # If not connected, show the crossed headset icon
    echo "$ICON_DISCONNECTED"
else
    # Check the current Bluetooth profile of the device
    PROFILE=$(pactl list cards short | grep $DEVICE_MAC | awk '{print $2}' | xargs pactl list cards | grep "Active Profile" | awk '{print $3}')

    if [[ $PROFILE == *"headset_head_unit"* ]]; then
        # HFP/HSP Profile - Show headset with microphone icon
        echo "$ICON_HEADSET_MIC"
    elif [[ $PROFILE == *"a2dp_sink"* ]]; then
        # A2DP Profile - Show normal headset icon
        echo "$ICON_HEADSET"
    else
        # Fallback in case an unexpected profile is detected
        echo "$ICON_FALLBACK"
    fi
fi
