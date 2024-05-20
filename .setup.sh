#!/bin/bash

VERBOSE=0
FULL=0
PRUSA=0

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"

while [[ $# -gt 0 ]]; do
	case "$1" in
		--verbose)
			VERBOSE=1
			shift
			;;
		--full)
			FULL=1
			shift
			;;
		--prusa)
			PRUSA=1
			shift
			;;
	esac
done

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

	# tpm
	TPM_PATH="$HOME/.tmux/plugins/tpm"
	[ ! -d "$TPM_PATH" ] && git clone https://github.com/tmux-plugins/tpm "$TPM_PATH"

	sudo apt autoremove > /dev/null 2>&1
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

	if [ "$FULL" -eq 1 ]; then

		# openscad
		sudo apt install -y openscad
		# pycharm
		sudo snap install pycharm-community --classic
		# telegram
		sudo snap install telegram-desktop
		# slack
		sudo snap install slack

		if [ "$PRUSA" -eq 1 ]; then

			# bmap tools
			sudo apt install -y bmap-tools

			# kicad
			sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases
			sudo apt update
			sudo apt install kicad

		fi

	fi

	sudo apt autoremove > /dev/null 2>&1

}

install_themes() {

	# vim
	mkdir -p $HOME/.vim/colors
	wget -O $HOME/.vim/colors/gruvbox.vim https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim

	# gedit
	wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
	mkdir -p $HOME/.local/share/gedit/styles/
	mv dracula.xml $HOME/.local/share/gedit/styles/

	if [ "$FULL" -eq 1 ]; then

		# vim (openscad)
		mkdir -p $HOME/.vim/pack/vendor/start
		VIM_OPENSCAD_PATH="$HOME/.vim/pack/vendor/start/vim-openscad"
		[ ! -d "$VIM_OPENSCAD_PATH" ] && git clone https://github.com/sirtaj/vim-openscad.git "$VIM_OPENSCAD_PATH"
		VIM_PATH="$HOME/.vim/vimrc"
		grep -q "filetype plugin indent on" "$VIM_PATH" || echo "filetype plugin indent on" >> "$VIM_PATH"

	fi

}

if [ "$VERBOSE" -eq 1 ]; then

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

else

	echo "Update APT..."
	update_apt > /dev/null 2>&1

	echo "Update snap..."
	update_snap > /dev/null 2>&1

	echo "Install dependencies..."
	install_dependencies > /dev/null 2>&1

	echo "Install software..."
	install_software > /dev/null 2>&1

	echo "Install themes..."
	install_themes > /dev/null 2>&1

fi
