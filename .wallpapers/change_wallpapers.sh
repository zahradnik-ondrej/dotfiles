#!/bin/bash

export HYPRLAND_INSTANCE_SIGNATURE=$(cat $HOME/.config/hypr/hyprland_signature.txt)

source /tmp/sun_times.env

current_time=$(date +%H:%M)

echo "Current Time: $current_time"
echo "Dawn: $DAWN, Sunrise: $SUNRISE, Sunset: $SUNSET, Dusk: $DUSK"

if [[ "$current_time" > "$DAWN" && "$current_time" < "$SUNRISE" ]]; then
    variant="dawn.png"
    echo "Time of day detected: Dawn"
elif [[ "$current_time" > "$SUNRISE" && "$current_time" < "$SUNSET" ]]; then
    variant="day.png"
    echo "Time of day detected: Day"
elif [[ "$current_time" > "$SUNSET" && "$current_time" < "$DUSK" ]]; then
    variant="dusk.png"
    echo "Time of day detected: Dusk"
else
    variant="night.png"
    echo "Time of day detected: Night"
fi

wallpapers=("$HOME/.wallpapers/forest" "$HOME/.wallpapers/lake" "$HOME/.wallpapers/mountain")

day_of_year=$(date +%-j)
echo "Day of the Year: $day_of_year"

folder_index=$((day_of_year % ${#wallpapers[@]}))
folder="${wallpapers[$folder_index]}"

echo "Selected Wallpaper Folder: $folder"
wallpaper_path="$folder/$variant"
echo "Final Wallpaper Path: $wallpaper_path"

current_wallpaper=$(hyprctl hyprpaper listactive | grep -P '^ = ' | awk '{print $2}')
echo "Current Active Wallpaper: $current_wallpaper"

if [[ "$current_wallpaper" != "$wallpaper_path" ]]; then
  echo "Wallpaper change detected. Applying new wallpaper..."
  hyprctl hyprpaper preload "$wallpaper_path"
  hyprctl hyprpaper wallpaper ,$wallpaper_path
else
  echo "Wallpaper is already set. No changes applied."
fi
