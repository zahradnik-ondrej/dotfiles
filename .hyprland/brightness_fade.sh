#!/bin/bash

DEFAULT_STEP=100

adjust_brightness() {

  local absolute_target="$1"
  local step="${2:-$DEFAULT_STEP}"

  local current_value=$(brightnessctl g)
  local ddc_displays=($(ddcutil detect | awk '/Display [0-9]/ { print $2 }'))

  local max=$(brightnessctl m)
  local current_target=$(( current_value * 100 / max ))

  if [[ "$absolute_target" == *% ]]; then
    absolute_target=${absolute_target%\%}
  fi

  while (( current_target > absolute_target + step || current_target < absolute_target - step )); do

    current_target=$(( current_target + (absolute_target > current_target ? step : -step) ))

    if (( current_target < 1 )); then current_target=1; fi
    if (( current_target > 100 )); then current_target=100; fi

    brightnessctl set "${current_target}%"

    for display in "${ddc_displays[@]}"; do
      ddcutil --display "$display" setvcp 10 "$current_target"
    done

  done

  brightnessctl set "${absolute_target}%"
  for display in "${ddc_displays[@]}"; do
    ddcutil --display "$display" setvcp 10 "$absolute_target"
  done

}

[[ "$1" =~ ^[0-9]{1,3}%?$ && ${1%\%} -ge 0 && ${1%\%} -le 100 && ( -z "$2" || "$2" =~ ^[0-9]+$ ) ]] || exit 1

adjust_brightness "$1" "$2"
