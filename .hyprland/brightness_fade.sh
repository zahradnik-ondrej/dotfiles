#!/bin/bash

DEFAULT_STEP=250
DEFAULT_DELAY=0.05
MIN_BRIGHTNESS=1

MAX_BRIGHTNESS=$(brightnessctl m)

adjust_brightness() {
    local target=${1:-}
    local step=${2:-$DEFAULT_STEP}
    local current=$(brightnessctl get)

    if [[ -z "$target" ]]; then
        target=$([ "$3" == "in" ] && echo "$MAX_BRIGHTNESS" || echo "$MIN_BRIGHTNESS")
    fi

    if [[ "$target" == *% ]]; then
        target=$(( MAX_BRIGHTNESS * ${target%\%} / 100 ))
    fi

    while (( current > target + step || current < target - step )); do
        current=$(( current + (target > current ? step : -step) ))

        if (( current < MIN_BRIGHTNESS )); then current=$MIN_BRIGHTNESS; fi
        if (( current > MAX_BRIGHTNESS )); then current=$MAX_BRIGHTNESS; fi

        brightnessctl set "$current"
        sleep "$DEFAULT_DELAY"
    done

    brightnessctl set "$target"
}

case "$1" in
    --fade-out) adjust_brightness "${2:-}" "${3:-$DEFAULT_STEP}" "out" ;;
    --fade-in) adjust_brightness "${2:-}" "${3:-$DEFAULT_STEP}" "in" ;;
    *) echo "Usage: $0 --fade-out [target[%]] [step] | --fade-in [target[%]] [step]"; exit 1 ;;
esac
