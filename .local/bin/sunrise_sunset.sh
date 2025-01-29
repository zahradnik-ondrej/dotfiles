#!/bin/bash

LATITUDE=50.08804
LONGITUDE=14.42076

API_RESPONSE=$(curl -s "https://api.sunrise-sunset.org/json?lat=$LATITUDE&lng=$LONGITUDE&formatted=0")

DAWN=$(echo "$API_RESPONSE" | jq -r '.results.civil_twilight_begin')
SUNRISE=$(echo "$API_RESPONSE" | jq -r '.results.sunrise')
SUNSET=$(echo "$API_RESPONSE" | jq -r '.results.sunset')
DUSK=$(echo "$API_RESPONSE" | jq -r '.results.civil_twilight_end')

DAWN=$(date -d "$DAWN" +%H:%M)
SUNRISE=$(date -d "$SUNRISE" +%H:%M)
SUNSET=$(date -d "$SUNSET" +%H:%M)
DUSK=$(date -d "$DUSK" +%H:%M)

echo "export DAWN=\"$DAWN\"" > /tmp/sun_times.env
echo "export SUNRISE=\"$SUNRISE\"" >> /tmp/sun_times.env
echo "export SUNSET=\"$SUNSET\"" >> /tmp/sun_times.env
echo "export DUSK=\"$DUSK\"" >> /tmp/sun_times.env
