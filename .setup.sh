#!/bin/bash

VERBOSE=0

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"

if [ "$1" == "--verbose" ]; then
	VERBOSE=1
fi

update_apt() {
	sudo apt update
	sudo apt upgrade -y
}

install_dependencies() {
	# wget
	sudo apt install -y wget
}

install_software() {
	# mc / tmux / tree / bmap tools
	sudo apt install -y mc tmux tree bmap-tools
}

install_themes() {
	# gedit
	wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
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
	sudo apt autoremove > /dev/null 2>&1
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
	sudo apt autoremove -y
fi
