#!/bin/bash

INTERNAL="eDP-1"
EXTERNAL="DP-1"

SETUP_1="810TL04"
SETUP_2="GJHJ804"

EDP1_SCALE=1.0
DP1_SCALE=1.0

current_setup=0

while true; do

    external_info=$(hyprctl monitors all | grep -wA 5 "$EXTERNAL")
    external_serial=$(echo "$external_info" | grep "serial:" | awk '{print $2}')

    if [ -z "$external_serial" ]; then

      if [ "$current_setup" != 0 ]; then

          hyprctl keyword monitor "$INTERNAL, preferred, auto, $EDP1_SCALE"

          current_setup=0

      fi

    else

      if [ "$external_serial" == "$SETUP_1" ]; then

        if [ "$current_setup" != 1 ]; then

          hyprctl keyword monitor "$EXTERNAL, preferred, auto, $DP1_SCALE"
          hyprctl keyword monitor "$INTERNAL, disable"

          current_setup=1

        fi

      elif [ "$external_serial" == "$SETUP_2" ]; then

        if [ "$current_setup" != 2 ]; then

          internal_resolution=$(hyprctl monitors all | grep -wA 1 "$INTERNAL" | awk '/@/')
          internal_width=$(echo "$internal_resolution" | awk -F 'x' '{print $1}')
          internal_height=$(echo "$internal_resolution" | awk -F 'x' '{print $2}' | cut -d'@' -f1)

          external_resolution=$(hyprctl monitors all | grep -wA 1 "$EXTERNAL" | awk '/@/')
          external_width=$(echo "$external_resolution" | awk -F 'x' '{print $1}')
          external_height=$(echo "$external_resolution" | awk -F 'x' '{print $2}' | cut -d'@' -f1)

          internal_y_offset=$(echo "($external_height - $internal_height) * $EDP1_SCALE" | bc)
          external_x_offset=$(echo "$internal_width * $DP1_SCALE" | bc)

          echo "$INTERNAL: ${internal_width}x${internal_height}"
          echo "$EXTERNAL: ${external_width}x${external_height}"

          hyprctl keyword monitor "$INTERNAL, preferred, 0x${internal_y_offset}, $EDP1_SCALE"
          hyprctl keyword monitor "$EXTERNAL, preferred, ${external_x_offset}x0, $DP1_SCALE"

          current_setup=2

        fi

      fi

    fi

    sleep 2

done
