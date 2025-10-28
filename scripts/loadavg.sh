#!/bin/bash

# Get the load average
loadavg=$(cat /proc/loadavg | awk '{ print $1 }')

# Compare the load average and print with color
if (( $(echo "$loadavg < 6.0" |bc -l) )); then
    # Print in green
    echo "<span color='white'>$loadavg</span>"
elif (( $(echo "$loadavg < 10.0" |bc -l) )); then
    # Print in yellow
    echo "<span color='yellow'>$loadavg</span>"
elif (( $(echo "$loadavg < 12.0" |bc -l) )); then
    # Print in red
    echo "<span color='yellow' weight='bold'>$loadavg</span>"
else
    # Print in bold red (Pango does support bold)
    echo "<span color='red' weight='bold'>$loadavg</span>"
fi
