#!/bin/bash

source "$HOME/.setup/.add_ppas.sh"
source "$HOME/.setup/.ask_install.sh"
source "$HOME/.setup/.cleanup.sh"
source "$HOME/.setup/.clone_repo.sh"
source "$HOME/.setup/.colors.sh"
source "$HOME/.setup/.install_appimage.sh"
source "$HOME/.setup/.install_apps.sh"
source "$HOME/.setup/.install_cursors.sh"
source "$HOME/.setup/.install_dependencies.sh"
source "$HOME/.setup/.install_fonts.sh"
source "$HOME/.setup/.install_icons.sh"
source "$HOME/.setup/.install_themes.sh"
source "$HOME/.setup/.run.sh"
source "$HOME/.setup/.update_apt.sh"
source "$HOME/.setup/.update_snap.sh"

sudo -v

category="Dev Environment"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- alacritty"
echo "- bat"
echo "- btop"
echo "- eza"
echo "- dotnet-sdk"
echo "- g++"
echo "- godot"
echo "- gparted"
echo "- love2d"
echo "- lua"
echo "- lunarvim"
echo "- midnight-commander"
echo "- neofetch"
echo "- neovide"
echo "- thefuck"
echo "- tmux"
echo "- tree"
echo "- vim"
echo "- zoxide"
dev_env=$(ask_install "${category}" "yes"; echo $?)

category="Hyprland"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- hyprland"
echo "- hyprlock"
echo "- hyprpaper"
echo "- hyprshot"
echo "- rofi"
echo "- sway-notification-center"
echo "- waybar"
hyprland=$(ask_install "${category}" "no"; echo $?)

category="TypeScript"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- chai"
echo "- mocha"
echo "- nodejs"
echo "- puppeteer"
echo "- typescript"
typescript=$(ask_install "${category}" "no"; echo $?)

category="3D"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- blender"
echo "- cura"
echo "- freecad"
echo "- openscad"
echo "- prusaslicer"
three_d=$(ask_install "${category}" "no"; echo $?)

category="Utilities"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- balena-etcher"
echo "- deluge"
echo "- ffmpeg"
echo "- flameshot"
echo "- gimp"
echo "- inkscape"
echo "- kicad"
echo "- libreoffice"
echo "- obs"
echo "- peek"
echo "- virtualbox"
echo "- vlc"
echo "- yt-dlp"
utilities=$(ask_install "${category}" "no"; echo $?)

category="Miscellaneous"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- proton-mail"
echo "- slack"
echo "- spotify"
echo "- steam"
echo "- telegram"
echo "- vivaldi"
misc=$(ask_install "${category}" "no"; echo $?)

printf "${yellow}${bold}"
echo "========= Add PPAs ========="
printf "${reset}"
add_ppas

printf "${yellow}${bold}"
echo "======== Update apt ========"
printf "${reset}"
run update_apt

printf "${yellow}${bold}"
echo "======= Update snap ========"
printf "${reset}"
run update_snap

printf "${yellow}${bold}"
echo "=== Install dependencies ==="
printf "${reset}"
install_dependencies

printf "${yellow}${bold}"
echo "======= Install apps ======="
printf "${reset}"
install_apps

printf "${yellow}${bold}"
echo "===== Install cursors ======"
printf "${reset}"
install_cursors

printf "${yellow}${bold}"
echo "====== Install themes ======"
printf "${reset}"
install_themes

printf "${yellow}${bold}"
echo "====== Install fonts ======"
printf "${reset}"
install_fonts

printf "${yellow}${bold}"
echo "====== Install icons ======"
printf "${reset}"
install_icons

printf "${yellow}${bold}"
echo "===== Cleanup ====="
printf "${reset}"
run cleanup
