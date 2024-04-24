#!/bin/bash

VERBOSE=0

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"

if [ "$1" == "--verbose" ]; then
	VERBOSE=1
fi

sudo = 0
if [[ $EUID -eq 0 ]]; then
   sudo=1
fi

update_apt() {
	if [[ $sudo -eq 1 ]]; then
		sudo apt update
		sudo apt upgrade -y
	fi
}

install_dependencies() {

	if [[ $sudo -eq 1 ]]; then
		# wget / docker / xsel
		sudo apt install -y wget docker xsel
	fi

	# tpm
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

install_software() {
	if [[ $sudo -eq 1 ]]; then
		# vim / tmux / tree / g++
		sudo apt install -y vim-gtk tmux tree g++
	fi
}

install_themes() {
	# vim
	mkdir -p ~/.vim/colors
	wget -O ~/.vim/colors/gruvbox.vim https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim
	# gedit
	wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
	mkdir -p ~/.local/share/gedit/styles/
	mv dracula.xml $HOME/.local/share/gedit/styles/
}

if [ "$VERBOSE" -eq 0 ]; then
	echo "Update APT..."
	update_apt > /dev/null 2>&1
	echo "Install dependencies..."
	install_dependencies > /dev/null 2>&1
	echo "Install software..."
	install_software > /dev/null 2>&1
	echo "Install themes..."
	install_themes > /dev/null 2>&1
	if [[ $sudo -eq 1 ]]; then
		sudo apt autoremove > /dev/null 2>&1
	fi
else
	printf "${yellow}${bold}"
	echo "Update APT..."
    printf "${reset}"
    update_apt
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
	if [[ $sudo -eq 1 ]]; then
		sudo apt autoremove -y
	fi
fi
