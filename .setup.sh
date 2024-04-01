#!/bin/bash

update_apt() {
	# apt
	sudo apt update
	sudo apt upgrade -y
}

install_dependencies() {
	# flatpak
    sudo apt install -y flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

install_software() {
	# mc / tmux / tree / emacs / bmap tools
	sudo apt install -y mc tmux tree emacs bmap-tools
	# telegram / prusaslicer / spotify
	sudo snap install telegram-desktop prusa-slicer spt
	# godot
	flatpak install --noninteractive flathub org.godotengine.Godot
	# neovim
	sudo snap install nvim --classic
}

install_themes() {
	# gedit
	wget https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
	mv dracula.xml $HOME/.local/share/gedit/styles/
	# telegram
	[ ! -d "telegram" ] && git clone https://github.com/dracula/telegram.git
	# godot
	[ ! -d "godot" ] && git clone https://github.com/dracula/godot.git
	cat 'godot/theme.tres' >> ~/.var/app/org.godotengine.Godot/editor_settings-3.tres
}

setup_ssh() {
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_ed25519
}

update_apt
install_dependencies
install_software
install_themes
setup_ssh

sudo apt autoremove -y
