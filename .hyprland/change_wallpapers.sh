#!/bin/bash

export HYPRLAND_INSTANCE_SIGNATURE=$(cat $HOME/.config/hypr/hyprland_signature.txt)

source /tmp/sun_times.env

day_of_year=$(date +%-j)
echo "Day of the Year: $day_of_year"

current_time=$(date +%H:%M)

echo "Current Time: $current_time"
echo "Dawn: $DAWN, Sunrise: $SUNRISE, Sunset: $SUNSET, Dusk: $DUSK"

if [[ "$current_time" > "$DAWN" && "$current_time" < "$SUNRISE" ]]; then
    variant="the_voyage_of_life_childhood_1971.16.1.jpg"
    echo "Time of day detected: Dawn"
elif [[ "$current_time" > "$SUNRISE" && "$current_time" < "$SUNSET" ]]; then
    variant="the_voyage_of_life_youth_1971.16.2.jpg"
    echo "Time of day detected: Day"
elif [[ "$current_time" > "$SUNSET" && "$current_time" < "$DUSK" ]]; then
    variant="the_voyage_of_life_manhood_1971.16.3.jpg"
    echo "Time of day detected: Dusk"
else
    variant="the_voyage_of_life_old_age_1971.16.4.jpg"
    echo "Time of day detected: Night"
fi

wallpaper_dir="$HOME/.wallpapers"
wallpaper_path="$wallpaper_dir/$variant"
echo "Selected Wallpaper Path: $wallpaper_path"

current_wallpaper=$(hyprctl hyprpaper listactive | grep -P '^ = ' | awk '{print $2}')
echo "Current Active Wallpaper: $current_wallpaper"

if [[ "$current_wallpaper" != "$wallpaper_path" ]]; then
  echo "Wallpaper change detected. Applying new wallpaper..."
  hyprctl hyprpaper preload "$wallpaper_path"
  hyprctl hyprpaper wallpaper ,$wallpaper_path
else
  echo "Wallpaper is already set. No changes applied."
fi

