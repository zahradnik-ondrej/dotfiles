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

  echo "Sunrise Time: $SUNRISE"
  echo "Sunset Time: $SUNSET"
  echo

  if [[ "$total_minutes" -ge "$sunrise_minutes" ]] && [[ "$total_minutes" -lt "$sunset_minutes" ]]; then
    echo "Daytime Mode!"
    factor=$(echo "scale=4; ($total_minutes - $sunrise_minutes) / ($sunset_minutes - $sunrise_minutes)" | bc)
    echo "Factor for Daytime: $factor"
    temp=$(echo "$NIGHT_TEMP + ($factor * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
  else
    echo "Nighttime Mode!"
    
    night_end=$((sunrise_minutes + 1440))
    night_midpoint=$(((sunset_minutes + night_end) / 2))

    echo "Night Midpoint: $(date -d "00:00 today +$((night_midpoint % 1440)) minutes" +"%H:%M")"
    
    if [[ "$total_minutes" -lt "$sunset_minutes" ]]; then
      total_minutes=$((total_minutes + 1440))
    fi
    
    if [[ "$total_minutes" -le "$night_midpoint" ]]; then
      factor=$(echo "scale=4; ($total_minutes - $sunset_minutes) / ($night_midpoint - $sunset_minutes)" | bc)
      echo "Factor for Night (Warming Up): $factor"
      temp=$(echo "$DAY_TEMP - ($factor * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
    else
      factor=$(echo "scale=4; ($total_minutes - $night_midpoint) / ($night_end - $night_midpoint)" | bc)
      echo "Factor for Night (Cooling Down): $factor"
      temp=$(echo "$NIGHT_TEMP + ($factor * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
    fi
  fi

  echo "Calculated Temperature: $(echo $temp | awk '{print int($1)}')"
  echo

  hyprsunset --temperature "$temp"
  # gammastep -O "$temp"

  sleep 60
  
done

