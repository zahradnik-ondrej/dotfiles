#!/bin/bash

INTERNAL="eDP-1"
EXTERNAL="DP-1"

SETUP_1="810TL04"
SETUP_2="GJHJ804"

EDP1_SCALE=1
DP1_SCALE=1.0

current_setup=-1

while true; do

    external_info=$(hyprctl monitors all | grep -wA 5 "$EXTERNAL")
    external_serial=$(echo "$external_info" | grep "serial:" | awk '{print $2}')

    if [ -z "$external_serial" ]; then

      echo "No external monitor detected."

      if [ "$current_setup" != 0 ]; then

        echo "Switching to internal monitor setup..."

        hyprctl keyword monitor "$INTERNAL, preferred, auto, $EDP1_SCALE"

        current_setup=0

      else

        echo "Internal monitor setup is already active. No changes applied."

      fi

    else

      if [ "$external_serial" == "$SETUP_1" ]; then

        echo "Detected Setup 1 ($SETUP_1)."

        if [ "$current_setup" != 1 ]; then

          echo "Applying Setup 1 configuration..."

          hyprctl keyword monitor "$EXTERNAL, preferred, auto, $DP1_SCALE"
          hyprctl keyword monitor "$INTERNAL, disable"

          current_setup=1

        else

          echo "Setup 1 is already active. No changes applied."

        fi

      elif [ "$external_serial" == "$SETUP_2" ]; then

        echo "Detected Setup 2 ($SETUP_2)."

        if [ "$current_setup" != 2 ]; then

          echo "Applying Setup 2 configuration..."

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

        else

          echo "Setup 2 is already active. No changes applied."

        fi

      else

        echo "Unrecognized external monitor setup. No changes applied."

      fi

    fi

    sleep 2

done
