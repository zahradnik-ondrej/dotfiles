#!/bin/bash

LATITUDE=50.08804
LONGITUDE=14.42076
OUT=/tmp/sun_times.env
[ "$(date -r "$OUT" +%F 2>/dev/null)" = "$(date +%F)" ] && exit 0
TMP=$(mktemp "${OUT}.XXXXXX") || exit 1
trap 'rm -f "$TMP"' EXIT

API_RESPONSE=$(curl -s --max-time 15 "https://api.sunrise-sunset.org/json?lat=$LATITUDE&lng=$LONGITUDE&formatted=0")
[ "$(echo "$API_RESPONSE" | jq -r '.status')" = "OK" ] || exit 1

DAWN=$(echo "$API_RESPONSE" | jq -r '.results.civil_twilight_begin')
SUNRISE=$(echo "$API_RESPONSE" | jq -r '.results.sunrise')
SUNSET=$(echo "$API_RESPONSE" | jq -r '.results.sunset')
DUSK=$(echo "$API_RESPONSE" | jq -r '.results.civil_twilight_end')

DAWN=$(date -d "$DAWN" +%H:%M) || exit 1
SUNRISE=$(date -d "$SUNRISE" +%H:%M) || exit 1
SUNSET=$(date -d "$SUNSET" +%H:%M) || exit 1
DUSK=$(date -d "$DUSK" +%H:%M) || exit 1

for v in "$DAWN" "$SUNRISE" "$SUNSET" "$DUSK"; do
  [[ "$v" =~ ^[0-9]{2}:[0-9]{2}$ ]] || exit 1
done

{
  echo "export DAWN=\"$DAWN\""
  echo "export SUNRISE=\"$SUNRISE\""
  echo "export SUNSET=\"$SUNSET\""
  echo "export DUSK=\"$DUSK\""
} > "$TMP"

chmod 644 "$TMP"
mv -f "$TMP" "$OUT"
trap - EXIT
