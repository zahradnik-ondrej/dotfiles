#!/bin/bash

INTERNAL="eDP-1"
EXTERNAL="DP-1"

SETUP_1="810TL04"
SETUP_2="GJHJ804"

current_setup=0

while true; do

    external_info=$(hyprctl monitors all | grep -wA 5 "$EXTERNAL")
    external_serial=$(echo "$external_info" | grep "serial:" | awk '{print $2}')

    if [ -z "$external_serial" ]; then

      if [ "$current_setup" != 0 ]; then

          hyprctl keyword monitor "$INTERNAL, preferred, auto, 1"

          current_setup=0

      fi

    else

      if [ "$external_serial" == "$SETUP_1" ]; then

        if [ "$current_setup" != 1 ]; then

          hyprctl keyword monitor "$EXTERNAL, preferred, auto, 1"
          hyprctl keyword monitor "$INTERNAL, disable"

          current_setup=1

        fi

      elif [ "$external_serial" == "$SETUP_2" ]; then

        if [ "$current_setup" != 2 ]; then

          internal_width=$(hyprctl monitors all | grep -wA 1 "$INTERNAL" | awk '/@/' | awk -F 'x' '{print $1}')
          internal_height=$(hyprctl monitors all | grep -wA 1 "$INTERNAL" | awk '/@/' | awk -F 'x' '{print $2}' | cut -d'@' -f1)

          external_width=$(hyprctl monitors all | grep -wA 1 "$EXTERNAL" | awk '/@/' | awk -F 'x' '{print $1}')
          external_height=$(hyprctl monitors all | grep -wA 1 "$EXTERNAL" | awk '/@/' | awk -F 'x' '{print $2}' | cut -d'@' -f1)

          echo "$INTERNAL: $((internal_width))x$((internal_height))"
          echo "$EXTERNAL: $((external_width))x$((external_height))"

          hyprctl keyword monitor "$INTERNAL, preferred, 0x$((external_height - internal_height)), 1"
          hyprctl keyword monitor "$EXTERNAL, preferred, $((internal_width))x0, 1"

          current_setup=2

        fi

      fi

    fi

    sleep 2
done
