# dailyphotosfromjapan


TODO: 
* set post location based on EXIF data (if available)
* document everything

## Caption

Be mindful of the limit of hastags being 30.

```
Follow for daily photos from all over Japan!
🗾
🇯🇵
🎑
🍜
👺
🗻
#japan #japaneseculture #japanlife #japan_photo #japangram #instagramjapan #japandaily #instajapan #instadaily #japanpic #japanbestpics #beautifuljapan #japon #ig_japan #japantrip #igjapan #japanlover #travel #tokyo #anime #japanese #art #manga #travel #photography #kyoto #visitjapan #旅行 #日本 #国内旅行
```

## IG token expiration

The Graph API longl-lived tokens expire every 60 days, and since these are facebook API keys, I haven't found a way to extend them. Thus there is a daily job setup that check the token validity and starts failing 7 days before the expiration time to warn me about renewing the token.

Steps of token renewal:

1. Go to https://developers.facebook.com/tools/explorer/ and generate an access token
2. Go to https://developers.facebook.com/tools/debug/accesstoken/ and paste the access token from #1. Click Debug.
3. Scroll down to the bottom, click 'Extend Access Token' to exchange the short-lived token for a long-lived one
4. Copy the resulting token
5. Go to https://github.com/markszabo/dailyphotosfromjapan/settings/secrets/actions and update the value of `IG_ACCESS_TOKEN`
6. Rerun the token expiration check job at https://github.com/markszabo/dailyphotosfromjapan/actions/workflows/check_token_expiration.yaml it shouldn't fail anymore
