#!/bin/bash

print_title() {

    local text="$1"
    local text_length=${#text}

    if (( text_length > 20 )); then
        return 1
    fi

    local adjusted_text_length=$((text_length + 2))

    local total_padding=$((28 - adjusted_text_length))

    local left_padding=$((total_padding / 2))
    local right_padding=$((total_padding - left_padding))

    printf "${yellow}${bold}%s %s %s${reset}\n" "$(printf '=%.0s' $(seq 1 $left_padding))" "$text" "$(printf '=%.0s' $(seq 1 $right_padding))"

}
