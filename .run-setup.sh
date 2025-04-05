#!/bin/bash

ERR_FILE="$HOME/.setup/error.log"

source "$HOME/.setup/add_ppas.sh"
source "$HOME/.setup/check.sh"
source "$HOME/.setup/cleanup.sh"
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
source "$HOME/.setup/update_apt.sh"

sudo -v

os=$(get_os)

if [ "$os" = "ubuntu" ]; then

  sudo apt-get install -y build-essential

  print_title "Add PPAs"
  add_ppas

  print_title "Update apt"
  check update_apt

fi

print_title "Install snap"
check install_snap

if [ "$os" = "manjaro" ]; then

  pacman -Qi base-devel >/dev/null || sudo pacman -S --noconfirm base-devel

  print_title "Install yay"
  check install_yay

fi

print_title "Install Flatpak"
check install_flatpak

print_title "Install Homebrew"
check install_homebrew

print_title "Install packages"
install_packages

print_title "Install apps"
install_apps

print_title "Install themes"
install_themes

print_title "Install fonts"
install_fonts

print_title "Load cron jobs"
load_cron_jobs

if [ "$os" = "ubuntu" ]; then
  print_title "Cleanup"
  check cleanup
fi
