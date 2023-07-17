#!/bin/bash

# check if the argument was supplied
if [ -z "$1" ]
then
  echo "Please provide the cheating factor as a command-line argument."
  exit 1
fi

# define cheating factor
cheat_factor=$1

function time_to_seconds {
  IFS=":" read -ra TIME <<< "$1"
  # base should be 10 not 8, so it works with numbers like 08 and 09 correctly
  echo $((10#${TIME[0]}*3600 + 10#${TIME[1]}*60 + 10#${TIME[2]}))
}

function seconds_to_time {
  printf "%02d:%02d:%02d" $(($1/3600)) $(($1%3600/60)) $(($1%60))
}

# get original output and time string
original_output=$(timew summary | tail -4 | head -1)
original_time_string=$(echo $original_output | awk '{print $NF}')

original_seconds=$(time_to_seconds $original_time_string)

# modify the calculation of cheat_seconds
cheat_seconds=$(printf "%.0f\n" $(echo "$original_seconds*$cheat_factor" | bc -l))

cheat_time_string=$(seconds_to_time $cheat_seconds)

# replace original time string with cheat time string in the original output
modified_output=$(echo "$original_output" | awk -v cheat="$cheat_time_string" '{$NF=cheat}1')

echo $modified_output

