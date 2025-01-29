#!/bin/bash

CRON_DIR="$HOME/.cron"

load_cron_jobs() {

    mkdir -p "$CRON_DIR"

    CRON_TEMP=$(mktemp)

    for cron_file in "$CRON_DIR"/*; do
      cat "$cron_file" >> "$CRON_TEMP"
    done

    crontab "$CRON_TEMP"

    rm "$CRON_TEMP"

    sudo systemctl restart cron

}
