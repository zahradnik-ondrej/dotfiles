#!/bin/sh
set -eu

SCALE=1.0
INTERNAL_RE="^(eDP|LVDS|DSI)"

mon=$(hyprctl monitors all -j)
sel() { printf '%s' "$mon" | jq -r --arg re "$INTERNAL_RE" ".[] | select(.name | test(\$re)$1) | .name"; }

internal=$(sel "")
external=$(sel " | not")

batch=""
if [ -n "$external" ]; then
    for m in $external; do batch="${batch}keyword monitor $m,preferred,auto,$SCALE;"; done
    for m in $internal; do batch="${batch}keyword monitor $m,disable;"; done
else
    for m in $internal; do batch="${batch}keyword monitor $m,preferred,auto,$SCALE;"; done
fi

[ -n "$batch" ] || { echo "monitor_toggle: no monitors detected" >&2; exit 1; }

echo "monitor_toggle: external=$(echo ${external:-none} | tr '\n' ' ')| internal=$(echo ${internal:-none} | tr '\n' ' ')"
hyprctl --batch "$batch" >/dev/null
