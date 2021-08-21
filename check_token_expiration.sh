#!/bin/bash
set -euo pipefail

# how long before the expiration start failing
((timelimit=7*24*60*60)) # 1 week

expiration_timestamp=$(curl --fail "https://graph.facebook.com/v11.0/debug_token?access_token=$IG_ACCESS_TOKEN&debug=all&format=json&input_token=$IG_ACCESS_TOKEN" | jq -r -c ".data.expires_at")
current_timestamp=$(date +"%s")

((remaining=(expiration_timestamp-current_timestamp)/60/60/24))
echo "The token will expire after $remaining days"

if [[ "$current_timestamp + $timelimit" -gt "$expiration_timestamp" ]]; then
  echo "Token is getting close to expiration, please replace it and put the new one into the Github secret."
  exit 1
else
  echo "Token is still valid for a while, no action required"
fi
