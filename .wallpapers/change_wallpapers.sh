#!/bin/bash

export HYPRLAND_INSTANCE_SIGNATURE=$(cat $HOME/.config/hypr/hyprland_signature.txt)

latitude=50.08804
longitude=14.42076

api_response=$(curl -s "https://api.sunrise-sunset.org/json?lat=$latitude&lng=$longitude&formatted=0")

dawn=$(echo $api_response | jq -r '.results.civil_twilight_begin')
sunrise=$(echo $api_response | jq -r '.results.sunrise')
sunset=$(echo $api_response | jq -r '.results.sunset')
dusk=$(echo $api_response | jq -r '.results.civil_twilight_end')

dawn=$(date -d "$dawn" +%H:%M)
sunrise=$(date -d "$sunrise" +%H:%M)
sunset=$(date -d "$sunset" +%H:%M)
dusk=$(date -d "$dusk" +%H:%M)

echo "Dawn: $dawn"
echo "Day: $sunrise"
echo "Dusk: $sunset"
echo "Night: $dusk"

current_time=$(date +%H:%M)

if [[ "$current_time" > "$dawn" && "$current_time" < "$sunrise" ]]; then
    variant="dawn.png"
elif [[ "$current_time" > "$sunrise" && "$current_time" < "$sunset" ]]; then
    variant="day.png"
elif [[ "$current_time" > "$sunset" && "$current_time" < "$dusk" ]]; then
    variant="dusk.png"
else
    variant="night.png"
fi

wallpapers=("$HOME/.wallpapers/forest" "$HOME/.wallpapers/lake" "$HOME/.wallpapers/mountain")
day_of_year=$(date +%-j)
folder_index=$((day_of_year % ${#wallpapers[@]}))
folder="${wallpapers[$folder_index]}"

wallpaper_path="$folder/$variant"

current_wallpaper=$(hyprctl hyprpaper listactive | grep -P '^ = ' | awk '{print $2}')

if [[ "$current_wallpaper" != "$wallpaper_path" ]]; then
  hyprctl hyprpaper preload "$wallpaper_path"
  hyprctl hyprpaper wallpaper ,$wallpaper_path
fi
