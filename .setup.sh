#!/bin/bash

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"
red="\e[35m"
green="\e[32m"
blue="\e[36m"

# set -x

run() {
    "$@" >/dev/null 2>&1
    local exit_code=$?

    if [ $exit_code -eq 0 ]; then
        printf "${green} ✔${reset}\n"
    else
        printf "${red} ✖${reset}\n"
    fi

    return $exit_code
}

add_ppas() {

	# kicad
	printf "${blue}kicad (PPA)${reset}"
	sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases

	# love2d
	printf "${blue}love2d (PPA)${reset}"
	run sudo add-apt-repository -y ppa:bartbes/love-stable

	# obs
	printf "${blue}obs (PPA)${reset}"
	run sudo add-apt-repository -y ppa:obsproject/obs-studio

	# freecad
	printf "${blue}freecad (PPA)${reset}"
	run sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable

	# steam
	printf "${blue}multiverse (PPA for steam)${reset}"
	run sudo add-apt-repository -y multiverse

	# peek
	printf "${blue}peek (PPA)${reset}"
	run sudo add-apt-repository -y ppa:peek-developers/stable

	# python
	printf "${blue}python (PPA)${reset}"
	run sudo add-apt-repository -y ppa:deadsnakes/ppa

}

update_apt() {
	sudo apt update
	sudo apt install -f --fix-missing
	sudo apt upgrade -y
}

update_snap() {
	sudo snap install core
	sudo snap refresh
}

install_dependencies() {

	# flatpak
	printf "${blue}flatpak${reset}"
	run sudo apt install -y flatpak
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	# docker (for browsh)
	printf "${blue}docker${reset}"
	run sudo snap install docker

	# cmake (for youcompleteme for vim)
	printf "${blue}cmake${reset}"
	run sudo apt install -y cmake

	# golang (for youcompleteme for vim)
	printf "${blue}golang${reset}"
	run sudo apt install -y golang-go

	# youcompleteme (for vim)
	printf "${blue}youcompleteme${reset}\n"
	[ -d "YouCompleteMe" ] && rm -rf "YouCompleteMe"
	git clone https://github.com/ycm-core/YouCompleteMe.git
	cd YouCompleteMe
	git submodule update --init --recursive
	python3 install.py --all --verbose

	# tpm (for tmux)
	printf "${blue}tpm${reset}"
	TPM_PATH="$HOME/.tmux/plugins/tpm"
	[ -d "$TPM_PATH" ] && rm -rf "$TPM_PATH"
	run git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"

	# xsel (for tmux)
	printf "${blue}xsel${reset}"
	run sudo apt install -y xsel

	# chromium (for puppeteer)
	printf "${blue}chromium${reset}"
	run sudo apt install -y chromium-browser

	# nodejs
	printf "${blue}nodejs${reset}\n"
	wget -qO- https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install -y nodejs

	# typescript
	printf "${blue}typescript${reset}"
	run npm install typescript @types/node --save-dev

	# puppeteer / mocha / chai
	printf "${blue}puppeteer / mocha / chai${reset}"
	run npm install puppeteer mocha chai @types/mocha @types/chai --save-dev

	# pip (for yt-dlp)
	printf "${blue}pip${reset}"
	run sudo apt install -y python3-pip

	# dconf (for dracula for gnome terminal)
	printf "${blue}dconf${reset}"
	run sudo apt install -y dconf-cli

	# expect (for dracula for gnome terminal)
	printf "${blue}expect${reset}"
	run sudo apt install -y expect

	# appindicator (for proton-vpn)
	printf "${blue}appindicator)${reset}"
	run sudo apt install -y libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator

}

configure_netrc() {
    NETRC_FILE="$HOME/.netrc"

    [ -e "$HOME/.private_env_vars" ] && source "$HOME/.private_env_vars"

    GITHUB_MACHINE="github.com"
    GITHUB_LOGIN="zahradnik-ondrej"
    GITHUB_PASSWORD="$GITHUB_PAT"

    GITLAB_MACHINE="gitlab.com"
    GITLAB_LOGIN="ondra-zahradnik"
    GITLAB_PASSWORD="$GITLAB_PAT"

    cat <<EOF > $NETRC_FILE
machine $GITHUB_MACHINE
login $GITHUB_LOGIN
password $GITHUB_PASSWORD

machine $GITLAB_MACHINE
login $GITLAB_LOGIN
password $GITLAB_PASSWORD
EOF

    chmod 600 $NETRC_FILE
}

install_software() {

	# vim
	printf "${blue}vim${reset}"
	run sudo apt install -y vim

	# tmux
	printf "${blue}tmux${reset}"
	run sudo apt install -y tmux

	# tree
	printf "${blue}tree${reset}"
	run sudo apt install -y tree

	# g++
	printf "${blue}g++${reset}"
	run sudo apt install -y g++

	# openscad
	printf "${blue}openscad${reset}"
	run sudo apt install -y openscad

	# pycharm
	printf "${blue}pycharm${reset}"
	run sudo snap install pycharm-professional --classic

	# telegram
	printf "${blue}telegram${reset}"
	run sudo snap install telegram-desktop

	# slack
	printf "${blue}slack${reset}"
	run sudo snap install slack

	# kicad
	printf "${blue}kicad${reset}"
	run sudo apt install -y kicad

	# cura
	printf "${blue}cura${reset}\n"
	CURA_EXPECTED_VERSION="Version: 5735cc5"
	CURA_DOWNLOAD_URL="https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage"
	CURA_APPIMAGE_PATH="/opt/cura"
	CURA_APPIMAGE="$CURA_APPIMAGE_PATH/Cura.AppImage"
	CURA_VERSION="none"
	[ -f "$CURA_APPIMAGE" ] && CURA_VERSION=$("$CURA_APPIMAGE" --appimage-version 2>&1)

	if [ "$CURA_VERSION" != "$CURA_EXPECTED_VERSION" ]; then
		sudo mkdir -p "$CURA_APPIMAGE_PATH"
		sudo wget -O "$CURA_APPIMAGE" "$CURA_DOWNLOAD_URL"
		sudo chmod +x "$CURA_APPIMAGE"
	fi

	# deluge
	printf "${blue}deluge${reset}"
	run sudo apt install -y deluge

	# vlc
	printf "${blue}vlc${reset}"
	run sudo apt install -y vlc

	# godot
	printf "${blue}godot${reset}"
	run sudo flatpak install -y flathub org.godotengine.Godot

	# balenaEtcher
	printf "${blue}balenaEtcher${reset}\n"
	ETCHER_EXPECTED_VERSION="Version: effcebc"
	ETCHER_DOWNLOAD_URL="https://github.com/balena-io/etcher/releases/download/v1.18.0/balenaEtcher-1.18.0-x64.AppImage"
	ETCHER_APPIMAGE_PATH="/opt/balenaEtcher"
	ETCHER_APPIMAGE="$ECTHER_APPIMAGE_PATH/balenaEtcher.AppImage"
	ETCHER_VERSION="none"
	[ -f "$ETCHER_APPIMAGE" ] && ETCHER_VERSION=$("$ETCHER_APPIMAGE" --appimage-version 2>&1)

	if [ "$ETCHER_VERSION" != "$ETCHER_EXPECTED_VERSION" ]; then
		sudo mkdir -p "$ETCHER_APPIMAGE_PATH"
		sudo wget -O "$ECTHER_APPIMAGE" "$ETCHER_DOWNLOAD_URL"
		sudo chmod +x "$ETCHER_APPIMAGE"
	fi


	# yt-dlp
	printf "${blue}yt-dlp${reset}"
	run pip3 install --upgrade yt-dlp

	# ffmpeg
	printf "${blue}ffmpeg${reset}"
	run sudo apt install -y ffmpeg

	# nautilus
	printf "${blue}nautilus${reset}"
	run sudo apt install -y nautilus

	# surfshark
	printf "${blue}surfshark${reset}"
	run sudo snap install surfshark

	# neofetch
	printf "${blue}neofetch${reset}"
	run sudo apt install -y neofetch

	# lua
	printf "${blue}lua${reset}"
	run sudo apt install -y lua5.3

	# love2d
	printf "${blue}love2d${reset}"
	run sudo apt install -y love

	# obs
	printf "${blue}obs${reset}"
	run sudo apt install -y obs-studio

	# freecad
	printf "${blue}freecad${reset}"
	run sudo apt install -y freecad

	# blender
	printf "${blue}blender${reset}"
	run sudo snap install blender --classic

	# steam
	printf "${blue}steam${reset}"
	run sudo apt install -y steam

	# spotify
	printf "${blue}spotify${reset}"
	run sudo snap install spotify

	# prusaslicer
	printf "${blue}prusaslicer${reset}"
	run sudo flatpak install -y flathub com.prusa3d.PrusaSlicer

	# libreoffice
	printf "${blue}libreoffice${reset}"
	run sudo apt install -y libreoffice

	# gparted
	printf "${blue}gparted${reset}"
	run sudo apt install -y gparted

	# htop
	printf "${blue}htop${reset}"
	run sudo apt install -y htop

	# inkscape
	printf "${blue}inkscape${reset}"
	run sudo apt install -y inkscape

	# peek
	printf "${blue}peek${reset}"
	run sudo apt install -y peek

	# flameshot
	printf "${blue}flameshot${reset}"
	run sudo apt install -y flameshot

	# signal
	printf "${blue}signal${reset}"
	run sudo snap install signal-desktop

	# vivaldi
	printf "${blue}vivaldi${reset}"
	run sudo snap install vivaldi

	# dotnet-sdk
	printf "${blue}dotnet-sdk${reset}"
	run sudo apt install -y dotnet-sdk-8.0

	# python
	printf "${blue}python${reset}"
	run sudo apt install -y python3.12

}

install_themes() {

	# dracula (for gnome terminal)
	printf "${blue}dracula${reset}\n"
	[ -d "gnome-terminal" ] && rm -rf "gnome-terminal"
	git clone https://github.com/dracula/gnome-terminal
	cd gnome-terminal

	expect <<EOF
	set timeout -1

	spawn ./install.sh

	expect "Please select a color scheme:"
	send "1\r"

	expect {
		"You need to create a new default profile to continue. Continue?" {
			send "yes\r"
			expect "Please select a Gnome Terminal profile:"
			send "1\r"
		}
		"Please select a Gnome Terminal profile:" {
			send "1\r"
		}
	}

EOF

	# dracula (for konsole)
	[ -d "konsole" ] && rm -rf "konsole"
	git clone https://github.com/dracula/konsole.git
	mv "konsole/Dracula.colorscheme" "$HOME/.local/share/konsole"
	rm -rf "konsole"

}

sudo -v

printf "${yellow}${bold}"
echo "Add PPAs..."
printf "${reset}"
add_ppas

printf "${yellow}${bold}"
printf "Update APT..."
printf "${reset}"
run update_apt

printf "${yellow}${bold}"
printf "Update snap..."
printf "${reset}"
run update_snap

printf "${yellow}${bold}"
echo "Install dependencies..."
printf "${reset}"
install_dependencies

printf "${yellow}${bold}"
printf "Configure .netrc..."
printf "${reset}"
run configure_netrc

printf "${yellow}${bold}"
echo "Install software..."
printf "${reset}"
install_software

printf "${yellow}${bold}"
printf "Install themes..."
printf "${reset}"
run install_themes

sudo apt autoclean >/dev/null 2>&1
sudo apt autoremove -y >/dev/null 2>&1
