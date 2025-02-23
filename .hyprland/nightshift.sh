#!/bin/bash

source /tmp/sun_times.env

DAY_TEMP=6500
NIGHT_TEMP=3000

while true; do
  now=$(date +"%H" | awk '{print $1 * 60}')
  minutes_now=$(date +"%M")
  total_minutes=$((now + minutes_now))

  echo "Current Time: $(date +"%H:%M")"
  echo "Total Minutes Since Midnight: $total_minutes"

  sunrise_minutes=$(date -d "$SUNRISE" +"%H" | awk '{print $1 * 60}')
  sunrise_minutes=$((sunrise_minutes + $(date -d "$SUNRISE" +"%M")))

  sunset_minutes=$(date -d "$SUNSET" +"%H" | awk '{print $1 * 60}')
  sunset_minutes=$((sunset_minutes + $(date -d "$SUNSET" +"%M")))

  echo "Sunrise Time: $SUNRISE -> Minutes Since Midnight: $sunrise_minutes"
  echo "Sunset Time: $SUNSET -> Minutes Since Midnight: $sunset_minutes"

  if [[ "$total_minutes" -ge "$sunrise_minutes" ]] && [[ "$total_minutes" -lt "$sunset_minutes" ]]; then
    echo "Daytime Mode"

    factor=$(echo "scale=4; ($total_minutes - $sunrise_minutes) / ($sunset_minutes - $sunrise_minutes)" | bc)
    echo "Factor for Daytime: $factor"

    temp=$(echo "$NIGHT_TEMP + ($factor * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
  else
    echo "Nighttime Mode"

    if [[ "$total_minutes" -ge "$sunset_minutes" ]]; then
      factor=$(echo "scale=4; ($total_minutes - $sunset_minutes) / (1440 - $sunset_minutes + $sunrise_minutes)" | bc)
      echo "Factor for Night (Post-Sunset): $factor"
    else
      factor=$(echo "scale=4; ($total_minutes + 1440 - $sunset_minutes) / (1440 - $sunset_minutes + $sunrise_minutes)" | bc)
      echo "Factor for Night (Pre-Sunrise): $factor"
    fi

    temp=$(echo "$DAY_TEMP - ($factor * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
  fi

  echo "Calculated Temperature: $temp"

  hyprsunset --temperature "$temp"
  # gammastep -O "$temp"
  
  sleep 1

done
