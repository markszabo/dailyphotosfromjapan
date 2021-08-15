#!/bin/bash

set -euo pipefail

# Config
# IG_ACCOUNT_ID=12345678 - set from GH secrets as environment variable
# IG_ACCESS_TOKEN=1234...4321 - set from GH secrets as environment variable
CAPTION="Follow for daily photos from all over Japan! 
🗾
🇯🇵
🎑
🍜
👺
🗻
#japan #japaneseculture #japanlife #japan_photo #japangram #instagramjapan #japandaily #instajapan #instadaily #japanpic #japanbestpics #beautifuljapan #japon #ig_japan #japantrip #igjapan #japanlover #travel #tokyo #anime #japanese #art #manga #travel #photography #kyoto #visitjapan #旅行 #日本 #国内旅行"
PHOTOS_FOLDER=photos/
USED_PHOTOS_FOLDER=usedphotos/
PUBLIC_URL_PREFIX=https://github.com/markszabo/dailyphotosfromjapan/raw/main/$PHOTOS_FOLDER

# Echo pick a random photo
echo "Picking random photo"
PHOTO=$(ls $PHOTOS_FOLDER | sort -R | tail -1)
PHOTO_URL=$PUBLIC_URL_PREFIX$PHOTO
echo "Photo selected: $PHOTO with URL: $PHOTO_URL"

# Upload photo
echo "Uploading photo"
CAPTION_URL_ENCODED=$(printf %s "$CAPTION" | jq -sRr @uri)
UPLOAD_RESPONSE=$(curl -X POST "https://graph.facebook.com/v10.0/$IG_ACCOUNT_ID/media?image_url=$PHOTO_URL&caption=$CAPTION_URL_ENCODED&access_token=$IG_ACCESS_TOKEN")
echo "Upload response:"
echo "$UPLOAD_RESPONSE" # e.g. {"id":"17918147077712345"}
UPLOAD_ID=$(echo "$UPLOAD_RESPONSE" | jq -r -c ".id")
echo "Parsed upload ID: $UPLOAD_ID"

# Publish photo
echo "Publishing photo"
PUBLISH_RESPONSE=$(curl -X POST "https://graph.facebook.com/v10.0/$IG_ACCOUNT_ID/media_publish?creation_id=$UPLOAD_ID&access_token=$IG_ACCESS_TOKEN")
echo "Publish response:"
echo "$PUBLISH_RESPONSE" # e.g. {"id":"17973968953123456"}

# Move photo
echo "Moving uploaded photo"
mv $PHOTOS_FOLDER$PHOTO $USED_PHOTOS_FOLDER$PHOTO

# Commit and push changes
echo "Commiting and pushing changes back to the repo"
git add --all
git commit -m "Moving uploaded photo $PHOTO"
git push
