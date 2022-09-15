#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo "To use this script copy request as curl from browser and paste without changes after $0 in command line"
    echo "You also need to provide PUSHOVER_TOKEN and PUSHOVER_USER environment variables to for this to work"
    exit 0
fi

# remove "curl" from pasted curl 
shift
response=0
while [ $response -eq 0 ]
do

raw_response=$(curl --compressed -s "$@")
response=$(echo "$raw_response" | jq '[.termsForService.termsInfoForDays[] | select(.message|contains("W tym dniu dostępne są terminy w innych")|not) | .termsCounter.termsNumber] | add')

echo "$raw_response"
echo "Total visits: $response"

[[ "$response" -gt 0 ]] && curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "message=Wizyta jest dostepna!" \
  https://api.pushover.net/1/messages.json


sleep 15

done
