#!/bin/bash

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"

set -x

update_apt() {
	sudo apt install -f --fix-missing
	sudo apt update
	sudo apt upgrade -y
}

update_snap() {
	sudo snap install core
	sudo snap refresh
}

install_dependencies() {
	# flatpak (for godot)
	sudo apt install -y flatpak
	# docker (for browsh)
	sudo apt install -y docker
	# youcompleteme (for vim)
	sudo apt install -y cmake golang-go
	cd "$HOME"
	[ ! -d "YouCompleteMe" ] && git clone https://github.com/ycm-core/YouCompleteMe.git
	cd YouCompleteMe
	git submodule update --init --recursive
	sudo python3 install.py --all --verbose
	# tpm (for tmux)
	TPM_PATH="$HOME/.tmux/plugins/tpm"
	[ ! -d "$TPM_PATH" ] && git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"
	# xsel (for tmux)
	sudo apt install -y xsel
	# chromium (for puppeteer)
	sudo apt install -y chromium-browser
	# nodejs
	wget -qO- https://deb.nodesource.com/setup_20.x | sudo -E bash -
	sudo apt install -y nodejs
	# typescript
	npm install typescript @types/node --save-dev
	# puppeteer / mocha / chai
	npm install puppeteer mocha chai @types/mocha @types/chai --save-dev
	# fuse (for cura)
	sudo apt install -y fuse
	# .private_env_vars
	[ -e "$HOME/.private_env_vars" ] && source "$HOME/.private_env_vars"
}

install_software() {
	# vim
	sudo apt install -y vim-gtk
	# tmux
	sudo apt install -y tmux
	# tree
	sudo apt install -y tree
	# g++
	sudo apt install -y g++
	# openscad
	sudo apt install -y openscad
	# pycharm
	sudo snap install pycharm-professional --classic
	# telegram
	sudo snap install telegram-desktop
	# slack
	sudo snap install slack
	# kicad
	sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases
	sudo apt update
	sudo apt install kicad
	# cura
	CURA_DOWNLOAD_URL="https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage"
	CURA_APPIMAGE_PATH="/opt/cura"
	sudo mkdir -p "$CURA_APPIMAGE_PATH"
	sudo wget -O "$CURA_APPIMAGE_PATH/Cura.AppImage" "$CURA_DOWNLOAD_URL"
	sudo chmod +x "$CURA_APPIMAGE_PATH/Cura.AppImage"
	# deluge
	sudo apt install -y deluge
	# vlc
	sudo apt install -y vlc
	# godot
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo flatpak install -y flathub org.godotengine.Godot
	# balena etcher
	ETCHER_DOWNLOAD_URL="https://github.com/balena-io/etcher/releases/download/v1.19.21/balenaEtcher-1.19.21-x64.AppImage"
	ETCHER_APPIMAGE_PATH="/opt/balenaEtcher"
	sudo mkdir -p "$ETCHER_APPIMAGE_PATH"
	sudo wget -O "$ETCHER_APPIMAGE_PATH/balenaEtcher.AppImage" "$ETCHER_DOWNLOAD_URL"
	sudo chmod +x "$ETCHER_APPIMAGE_PATH/balenaEtcher.AppImage"
}

printf "${yellow}${bold}"
echo "Update APT..."
printf "${reset}"
update_apt

printf "${yellow}${bold}"
echo "Update snap..."
printf "${reset}"
update_snap

printf "${yellow}${bold}"
echo "Install dependencies..."
printf "${reset}"
install_dependencies

printf "${yellow}${bold}"
echo "Install software..."
printf "${reset}"
install_software

sudo apt autoremove > /dev/null 2>&1
