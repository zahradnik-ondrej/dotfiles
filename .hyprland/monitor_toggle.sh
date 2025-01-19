#!/bin/bash

INTERNAL="eDP-1"
EXTERNAL="DP-1"

current_status="none"

while true; do

    if hyprctl monitors all | grep -qw "$EXTERNAL"; then
        if [ "$current_status" != "external" ]; then
            hyprctl keyword monitor "$EXTERNAL, preferred, auto, auto"
            hyprctl keyword monitor "$INTERNAL, disable"
            current_status="external"
        fi
    else
        if [ "$current_status" != "internal" ]; then
            hyprctl keyword monitor "$INTERNAL, preferred, auto, 1"
            current_status="internal"
        fi
    fi

    sleep 2
done
