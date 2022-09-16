#!/bin/bash
if [[ $# -eq 0 ]] ; then
    echo "To use this script copy request as curl from browser and paste without changes after $0 in command line"
    echo "You also need to provide PUSHOVER_TOKEN and PUSHOVER_USER environment variables to for this to work"
    echo "You may also set PUSHOVER_TITLE. If not, title will be Luxmed by default"

    exit 0
fi

title="${PUSHOVER_TITLE:-Luxmed}"

# remove "curl" from pasted curl 
shift
response=0
while [ $response -eq 0 ]
do

raw_response=$(curl --compressed -s "$@")

[[ "$raw_response" =~ "Unauthorized" ]] && curl -s \
  --form-string "token=$PUSHOVER_TOKEN" \
  --form-string "user=$PUSHOVER_USER" \
  --form-string "message=Auth is expired, please refresh curl query." \
  --form-string "title=$title" \
  https://api.pushover.net/1/messages.json \
&& exit 1

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
