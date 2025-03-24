#!/bin/bash

INTERNAL="eDP-1"
EXTERNAL="DP-1"
EXTERNAL_2="HDMI-A-1"

SETUP_1_SN="810TL04"
SETUP_2_SN="GJHJ804"
SETUP_2_SN_2="VTV069F9"

INTERNAL_SCALE=1.0
EXTERNAL_SCALE=1.0
EXTERNAL_2_SCALE=0.75

current_setup=-1

while true; do

    external_info=$(hyprctl monitors all | grep -E -wA 5 "$EXTERNAL|$EXTERNAL_2" | head -n 6)

    if [ -z "$external_info" ]; then

      echo "No external monitor detected."

      if [ "$current_setup" != 0 ]; then

        echo "Switching to internal monitor setup..."

        hyprctl keyword monitor "$INTERNAL, preferred, auto, $INTERNAL_SCALE"

        current_setup=0

      else

        echo "Internal monitor setup is already active. No changes applied."

      fi

    else

      external_serial=$(echo "$external_info" | grep "serial:" | awk '{print $2}')

      if [ "$external_serial" == "$SETUP_1_SN" ]; then

        echo "Detected Setup 1."

        if [ "$current_setup" != 1 ]; then

          echo "Applying Setup 1 configuration..."

          hyprctl keyword monitor "$EXTERNAL, preferred, auto, $EXTERNAL_SCALE"
          hyprctl keyword monitor "$INTERNAL, disable"

          current_setup=1

        else

          echo "Setup 1 is already active. No changes applied."

        fi

      elif [ "$external_serial" == "$SETUP_2_SN" ] || [ "$external_serial" == "$SETUP_2_SN_2" ]; then

        echo "Detected Setup 2."

        # if [ "$current_setup" != 2 ]; then

          echo "Applying Setup 2 configuration..."

          internal_resolution=$(hyprctl monitors all | grep -wA 1 "$INTERNAL" | awk '/@/')
          internal_width=$(echo "$internal_resolution" | awk -F 'x' '{print $1}')
          internal_height=$(echo "$internal_resolution" | awk -F 'x' '{print $2}' | cut -d'@' -f1)

          external_resolution=$(hyprctl monitors all | grep -wA 1 "$EXTERNAL" | awk '/@/')
          external_width=$(echo "$external_resolution" | awk -F 'x' '{print $1}')
          external_height=$(echo "$external_resolution" | awk -F 'x' '{print $2}' | cut -d'@' -f1)

          internal_y_offset=$(echo "($external_height - $internal_height) * $INTERNAL_SCALE" | bc)
          external_x_offset=$(echo "$internal_width" | bc)

          echo "$INTERNAL: ${internal_width}x${internal_height}"
          echo "$EXTERNAL: ${external_width}x${external_height}"

          if [ "$external_2_serial" == "$SETUP_2_SN_2" ]; then

            external_2_resolution=$(hyprctl monitors all | grep -wA 1 "$EXTERNAL_2" | awk '/@/')
            external_2_width=$(echo "$external_2_resolution" | awk -F 'x' '{print $1}')
            external_2_height=$(echo "$external_2_resolution" | awk -F 'x' '{print $2}' | cut -d'@' -f1)

            external_2_x_offset=$(echo "$internal_width + $external_width" | bc)
            external_2_y_offset=$(echo "($external_height - $external_2_width) / 2 * $EXTERNAL_2_SCALE" | bc)

            echo "$EXTERNAL_2: ${external_2_width}x${external_2_height}"

            hyprctl keyword monitor "$EXTERNAL_2, preferred, ${external_2_x_offset}x${external_2_y_offset}, $EXTERNAL_2_SCALE, transform, 1"

          fi

          hyprctl keyword monitor "$INTERNAL, preferred, 0x${internal_y_offset}, $INTERNAL_SCALE"
          hyprctl keyword monitor "$EXTERNAL, preferred, ${external_x_offset}x0, $EXTERNAL_SCALE"

          external_2_info=$(hyprctl monitors all | grep -wA 5 "$EXTERNAL_2")
          external_2_serial=$(echo "$external_2_info" | grep "serial:" | awk '{print $2}')

          current_setup=2

        # else

        #   echo "Setup 2 is already active. No changes applied."

        # fi

      else

        echo "Unrecognized external monitor setup. No changes applied."

      fi

    fi

    sleep 2

done
