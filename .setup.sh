#!/bin/bash

VERBOSE=0

bold="\e[1m"
reset="\e[0m"
yellow="\e[33m"

if [ "$1" == "--verbose" ]; then
	VERBOSE=1
fi

add_ppa() {
	# love2d
	#sudo add-apt-repository -y ppa:bartbes/love-stable
	# git-lfs
	curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
}

update_apt() {
	sudo apt update
	sudo apt upgrade -y
}

update_snap() {
	sudo snap install core
	sudo snap refresh
}

install_dependencies() {
	# flatpak
    sudo apt install -y flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

install_software() {
	# mc / tmux / tree / emacs / bmap tools / wireshark / tshark / lua / love2d / git-lfs
	sudo apt install -y mc tmux tree emacs bmap-tools wireshark-qt tshark lua5.4 love git-lfs
	# git-lfs
	git lfs install
	# telegram / prusaslicer / spotify-tui
	#sudo snap install telegram-desktop prusa-slicer spt
	# godot
	flatpak install --noninteractive flathub org.godotengine.Godot
	# neovim
	sudo snap install nvim --classic
	# lunarvim
	yes no | bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
	# cura
	sudo mkdir -p /opt/cura/
	cd /opt/cura
	sudo curl -L -o Cura.AppImage "https://github.com/Ultimaker/Cura/releases/download/5.7.0/UltiMaker-Cura-5.7.0-linux-X64.AppImage"
	sudo chmod +x Cura.AppImage
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

if [ "$VERBOSE" -eq 0 ]; then
	echo "Add PPAs..."
	add_ppa > /dev/null 2>&1
	echo "Update APT..."
	update_apt > /dev/null 2>&1
	echo "Update SNAP..."
	update_snap > /dev/null 2>&1
	echo "Install dependencies..."
	install_dependencies > /dev/null 2>&1
	echo "Install software..."
	install_software > /dev/null 2>&1
	#echo "Install themes..."
	#install_themes > /dev/null 2>&1
	echo "Install font..."
	install_font > /dev/null 2>&1
	sudo apt autoremove > /dev/null 2>&1
else
	printf "${yellow}${bold}"
	echo "Add PPAs..."
	printf "${reset}"
	add_ppa
	printf "${yellow}${bold}"
	echo "Update APT..."
    printf "${reset}"
    update_apt
	printf "${yellow}${bold}"
	echo "Update SNAP..."
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
	#printf "${yellow}${bold}"
	#echo "Install themes..."
    #printf "${reset}"
    #install_themes
	printf "${yellow}${bold}"
	echo "Install font..."
    printf "${reset}"
    install_font
	sudo apt autoremove -y
fi
