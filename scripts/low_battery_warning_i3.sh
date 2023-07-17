#!/bin/sh

# Change this to your battery device. 
# Find it with `ls /sys/class/power_supply/`.
# It is probably something like `BAT0` or `BAT1`.
BATTERY_DEVICE=BAT0

# Threshold for the warning
THRESHOLD=20

BATTERY_PATH="/sys/class/power_supply/$BATTERY_DEVICE"
BATTERY_STATUS=$(cat "$BATTERY_PATH/status")
BATTERY_CAPACITY=$(cat "$BATTERY_PATH/capacity")

if [ "$BATTERY_STATUS" = "Discharging" ] && [ "$BATTERY_CAPACITY" -le "$THRESHOLD" ]; then
    i3-nagbar -m "Battery level is below $THRESHOLD%, please connect the charger" -t warning
fi
