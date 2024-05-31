#!/bin/bash

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"

update_apt() {
	if [[ $sudo -eq 1 ]]; then
		sudo apt update
		sudo apt upgrade -y
	fi
}

update_snap() {
	if [[ $sudo -eq 1 ]]; then
		sudo snap install core
		sudo snap refresh
	fi
}

install_dependencies() {

	# wget
	sudo apt install -y wget
	# docker
	sudo apt install -y docker
	# xsel
	sudo apt install -y xsel
	# cmake
	sudo apt install -y cmake
	# nodejs
	wget -qO- https://deb.nodesource.com/setup_20.x | sudo -E bash -
	sudo apt install -y nodejs
	# npm
	sudo apt install -y npm
	# puppeteer / chai
	npm install puppeteer chai
	# typescript
	npm install typescript @types/node @types/chai --save-dev
	# tpm
	TPM_PATH="$HOME/.tmux/plugins/tpm"
	[ ! -d "$TPM_PATH" ] && git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"

	sudo apt autoremove > /dev/null 2>&1
}

install_software() {

	# vim
	sudo apt install -y vim-gtk

	# youcompleteme
	cd "$HOME"
	[ ! -d "YouCompleteMe" ] && git clone https://github.com/ycm-core/YouCompleteMe.git
	cd YouCompleteMe
	git submodule update --init --recursive
	python3 install.py --all

	# tmux
	sudo apt install -y tmux

	# tree
	sudo apt install -y tree

	# g++
	sudo apt install -y g++

	# openscad
	sudo apt install -y openscad

	# pycharm
	sudo snap install pycharm-community --classic

	# telegram
	sudo snap install telegram-desktop

	# slack
	sudo snap install slack

	# kicad
	sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases
	sudo apt update
	sudo apt install kicad

	sudo apt autoremove > /dev/null 2>&1

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
