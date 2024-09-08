#!/bin/bash

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"
blue="\e[36m"

# set -x

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
	printf "${blue}flatpak${reset}\n"
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	sudo apt install -y flatpak

	# docker (for browsh)
	printf "${blue}docker${reset}\n"
	sudo snap install docker --yes

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

	# yt-dlp
	printf "${blue}yt-dlp${reset}\n"
	pip3 install --upgrade yt-dlp

	# ffmpeg
	printf "${blue}ffmpeg${reset}\n"
	sudo apt install -y ffmpeg

	# neofetch
	printf "${blue}neofetch${reset}\n"
	sudo apt install -y neofetch

	# lua
	printf "${blue}lua${reset}\n"
	sudo apt install -y lua5.3

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
echo "Configure .netrc..."
printf "${reset}"
configure_netrc

printf "${yellow}${bold}"
echo "Install software..."
printf "${reset}"
install_software

sudo apt autoclean
sudo apt autoremove -y
