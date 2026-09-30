CRON_DIR="$HOME/.cron"

load_cron_jobs() {

  if [ "$os" = "manjaro" ]; then
    
    if ! pacman -Q cronie &>/dev/null; then
      sudo pacman -S --needed --noconfirm cronie
    fi

    sudo systemctl enable --now cronie.service
  fi

  mkdir -p "$CRON_DIR"

  CRON_TEMP=$(mktemp)

  for cron_file in "$CRON_DIR"/*; do
    [ -f "$cron_file" ] && cat "$cron_file" >> "$CRON_TEMP"
  done

  if [ -s "$CRON_TEMP" ]; then
    crontab "$CRON_TEMP"
  fi

  rm "$CRON_TEMP"

  if [ "$os" = "manjaro" ]; then
    sudo systemctl restart cronie
  elif [ "$os" = "ubuntu" ]; then
    sudo systemctl restart cron
  fi

}
