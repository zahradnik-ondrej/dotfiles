#!/bin/bash

DAY_TEMP=6500
NIGHT_TEMP=3000

mins() { date -d "$1" +"%H %M" | awk '{print $1 * 60 + $2}'; }

pgrep -x hyprsunset >/dev/null || { hyprsunset & sleep 1; }

while true; do

  source /tmp/sun_times.env

  now=$(date +"%H %M" | awk '{print $1 * 60 + $2}')
  dawn=$(mins "$DAWN")
  sunrise=$(mins "$SUNRISE")
  sunset=$(mins "$SUNSET")
  dusk=$(mins "$DUSK")

  ok=1
  for v in "$dawn" "$sunrise" "$sunset" "$dusk"; do
    case "$v" in ''|*[!0-9]*) ok=0 ;; esac
  done
  if [ "$ok" = 1 ]; then
    [ "$dawn" -gt 0 ] && [ "$sunrise" -gt "$dawn" ] && [ "$sunset" -gt "$sunrise" ] && [ "$dusk" -gt "$sunset" ] || ok=0
  fi
  if [ "$ok" = 0 ]; then
    echo "$(date +%H:%M) skip (bad sun times)"
    sleep 60
    continue
  fi

  if [ "$now" -ge "$sunrise" ] && [ "$now" -lt "$sunset" ]; then
    phase="day"
    temp=$DAY_TEMP
  elif [ "$now" -ge "$dawn" ] && [ "$now" -lt "$sunrise" ]; then
    phase="dawn"
    f=$(echo "scale=4; ($now - $dawn) / ($sunrise - $dawn)" | bc)
    temp=$(echo "$NIGHT_TEMP + ($f * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
  elif [ "$now" -ge "$sunset" ] && [ "$now" -lt "$dusk" ]; then
    phase="dusk"
    f=$(echo "scale=4; ($now - $sunset) / ($dusk - $sunset)" | bc)
    temp=$(echo "$DAY_TEMP - ($f * ($DAY_TEMP - $NIGHT_TEMP))" | bc)
  else
    phase="night"
    temp=$NIGHT_TEMP
  fi

  temp=$(echo "$temp" | awk '{print int($1)}')
  echo "$(date +%H:%M) $phase ${temp}K"

  hyprctl hyprsunset temperature "$temp" >/dev/null

  sleep 60

done
