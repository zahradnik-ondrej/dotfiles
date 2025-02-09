#!/bin/bash

CRON_DIR="$HOME/.cron"

load_cron_jobs() {

  if [ "$os" = "manjaro" ]; then
    sudo pacman -S --needed --noconfirm cronie
    sudo systemctl enable --now cronie.service
  fi

  mkdir -p "$CRON_DIR"

  CRON_TEMP=$(mktemp)

  for cron_file in "$CRON_DIR"/*; do
    cat "$cron_file" >> "$CRON_TEMP"
  done

  crontab "$CRON_TEMP"

  rm "$CRON_TEMP"

  if [ "$os" = "manjaro" ]; then
    sudo systemctl restart cronie
  elif [ "$os" = "ubuntu" ]; then
    sudo systemctl restart cron
  fi

}
