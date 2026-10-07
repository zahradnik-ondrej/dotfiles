#!/bin/bash

ERR_FILE="$HOME/.setup/error.log"

source "$HOME/.setup/status.sh"
source "$HOME/.setup/clone_repo.sh"
source "$HOME/.setup/colors.sh"
source "$HOME/.setup/get_os.sh"
source "$HOME/.setup/install_appimage.sh"
source "$HOME/.setup/install_apps.sh"
source "$HOME/.setup/install_flatpak.sh"
source "$HOME/.setup/install_fonts.sh"
source "$HOME/.setup/install_homebrew.sh"
source "$HOME/.setup/install_packages.sh"
source "$HOME/.setup/install_snap.sh"
source "$HOME/.setup/install_themes.sh"
source "$HOME/.setup/install_yay.sh"
source "$HOME/.setup/load_cron_jobs.sh"
source "$HOME/.setup/print_title.sh"
source "$HOME/.setup/run.sh"

sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &
SUDO_KEEPALIVE_PID=$!
trap 'kill $SUDO_KEEPALIVE_PID 2>/dev/null' EXIT

os=$(get_os)

# print_title "Install snap"
# status install_snap

if [ "$os" = "manjaro" ]; then

  pacman -Qi base-devel >/dev/null || sudo pacman -S --noconfirm base-devel

  print_title "Install yay"
  status install_yay

fi

# print_title "Install Flatpak"
# status install_flatpak

# print_title "Install Homebrew"
# status install_homebrew

print_title "Install packages"
install_packages

print_title "Install apps"
install_apps

print_title "Install themes"
install_themes

print_title "Install fonts"
install_fonts

print_title "Load cron jobs"
status load_cron_jobs
