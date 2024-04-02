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
	# lunarvim
	bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
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

install_font() {
	# jetbrainsmono nerd font
	FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.tar.xz"
	FONT_DIR="/usr/share/fonts/JetBrainsMonoNerdFont"
	TEMP_DIR=$(mktemp -d)
	wget -O "$TEMP_DIR/JetBrainsMono.tar.xz" "$FONT_URL"
	sudo mkdir -p "$FONT_DIR"
	sudo tar -xvf "$TEMP_DIR/JetBrainsMono.tar.xz" -C "$FONT_DIR"
	fc-cache -fv
    rm -rf "$TEMP_DIR"
}

update_apt
install_dependencies
install_software
install_themes
install_font

sudo apt autoremove -y
