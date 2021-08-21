#!/bin/bash
set -euo pipefail

# how long before the expiration start failing
((timelimit=7*24*60*60)) # 1 week

expiration_timestamp=$(curl --fail "https://graph.facebook.com/v11.0/debug_token?access_token=$IG_ACCESS_TOKEN&debug=all&format=json&input_token=$IG_ACCESS_TOKEN" | jq -r -c ".data.expires_at")
current_timestamp=$(date +"%s")

if [[ "$current_timestamp + $timelimit" -gt "$expiration_timestamp" ]]; then
  echo "Token is getting close to expiration, please replace it and put the new one to the github secret."
  exit 1
fi
