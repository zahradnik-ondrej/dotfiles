#!/bin/bash

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"
blue="\e[36m"

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
	printf "${blue}flatpak${reset}\n"
	sudo apt install -y flatpak

	# docker (for browsh)
	printf "${blue}docker${reset}\n"
	sudo snap install docker

	# youcompleteme (for vim)
	printf "${blue}youcompleteme${reset}\n"
	sudo apt install -y cmake golang-go
	cd "$HOME"
	[ ! -d "YouCompleteMe" ] && git clone https://github.com/ycm-core/YouCompleteMe.git
	cd YouCompleteMe
	git submodule update --init --recursive
	sudo python3 install.py --all --verbose

	# tpm (for tmux)
	printf "${blue}tpm${reset}\n"
	TPM_PATH="$HOME/.tmux/plugins/tpm"
	[ ! -d "$TPM_PATH" ] && git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"

	# xsel (for tmux)
	printf "${blue}xsel${reset}\n"
	sudo apt install -y xsel

	# chromium (for puppeteer)
	printf "${blue}chromium${reset}\n"
	sudo apt install -y chromium-browser

	# nodejs
	printf "${blue}nodejs${reset}\n"
	wget -qO- https://deb.nodesource.com/setup_20.x | sudo -E bash -
	sudo apt install -y nodejs

	# typescript
	printf "${blue}typescript${reset}\n"
	npm install typescript @types/node --save-dev

	# puppeteer / mocha / chai
	printf "${blue}puppeteer / mocha / chai${reset}\n"
	npm install puppeteer mocha chai @types/mocha @types/chai --save-dev

	# pip (for yt-dlp)
	printf "${blue}pip${reset}\n"
	sudo apt install -y python3-pip

	# dconf (for dracula for gnome terminal)
	printf "${blue}dconf${reset}\n"
	sudo apt install -y dconf-cli

	# .private_env_vars
	[ -e "$HOME/.private_env_vars" ] && source "$HOME/.private_env_vars"

}

install_software() {

	# vim
	printf "${blue}vim${reset}\n"
	sudo apt install -y vim

	# tmux
	printf "${blue}tmux${reset}\n"
	sudo apt install -y tmux

	# tree
	printf "${blue}tree${reset}\n"
	sudo apt install -y tree

	# g++
	printf "${blue}g++${reset}\n"
	sudo apt install -y g++

	# openscad
	printf "${blue}openscad${reset}\n"
	sudo apt install -y openscad

	# pycharm
	printf "${blue}pycharm${reset}\n"
	sudo snap install pycharm-professional --classic

	# telegram
	printf "${blue}telegram${reset}\n"
	sudo snap install telegram-desktop

	# slack
	printf "${blue}slack${reset}\n"
	sudo snap install slack

	# kicad
	printf "${blue}kicad${reset}\n"
	sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases
	sudo apt update
	sudo apt install -y kicad

	# cura
	printf "${blue}cura${reset}\n"
	CURA_DOWNLOAD_URL="https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage"
	CURA_APPIMAGE_PATH="/opt/cura"
	sudo mkdir -p "$CURA_APPIMAGE_PATH"
	sudo wget -O "$CURA_APPIMAGE_PATH/Cura.AppImage" "$CURA_DOWNLOAD_URL"
	sudo chmod +x "$CURA_APPIMAGE_PATH/Cura.AppImage"

	# deluge
	printf "${blue}deluge${reset}\n"
	sudo apt install -y deluge

	# vlc
	printf "${blue}vlc${reset}\n"
	sudo apt install -y vlc

	# godot
	printf "${blue}godot${reset}\n"
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo flatpak install -y flathub org.godotengine.Godot

	# balenaEtcher
	printf "${blue}balenaEtcher${reset}\n"
	ETCHER_DOWNLOAD_URL="https://github.com/balena-io/etcher/releases/download/v1.18.0/balenaEtcher-1.18.0-x64.AppImage"
	ETCHER_APPIMAGE_PATH="/opt/balenaEtcher"
	sudo mkdir -p "$ETCHER_APPIMAGE_PATH"
	sudo wget -O "$ETCHER_APPIMAGE_PATH/balenaEtcher.AppImage" "$ETCHER_DOWNLOAD_URL"
	sudo chmod +x "$ETCHER_APPIMAGE_PATH/balenaEtcher.AppImage"

	# yt-dlp
	printf "${blue}yt-dlp${reset}\n"
	pip3 install --upgrade yt-dlp

	# ffmpeg
	printf "${blue}ffmpeg${reset}\n"
	sudo apt install -y ffmpeg

	# nautilus
	printf "${blue}nautilus${reset}\n"
	sudo apt install -y nautilus

	# surfshark
	printf "${blue}surfshark${reset}\n"
	sudo snap install surfshark --beta

}

install_themes() {

	# dracula (for gnome terminal)
	printf "${blue}dracula${reset}\n"
	[ ! -d "$HOME/gnome-terminal" ] && git clone https://github.com/dracula/gnome-terminal
	cd gnome-terminal
	./install.sh

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

printf "${yellow}${bold}"
echo "Install themes..."
printf "${reset}"
install_themes

sudo apt autoremove > /dev/null 2>&1
