#!/bin/bash

reset="\e[0m"
bold="\e[1m"
reset_bold="\e[22m"
green="\e[32m"
yellow="\e[33m"
red="\e[35m"
cyan="\e[36m"

ask_install() {
	local name=$1
	local default=${2:-yes}

	local name_upper=$(echo "$name" | tr '[:lower:]' '[:upper:]')

	local options
	if [[ "$default" =~ ^[Yy] ]]; then
		options="[${green}Y${cyan}/n${cyan}]"
	else
		options="[${cyan}y/${red}N${cyan}]"
	fi

  while true; do
		read -p "$(echo -e "${cyan}Do you want to install packages in the ${bold}$name_upper${reset_bold} category? $options${cyan}: ${reset}")" answer

		if [[ -z "$answer" ]]; then
			answer=$default
		fi

		case $answer in
			[Yy]* ) return 1 ;;
			[Nn]* ) return 0 ;;
			* ) echo "Please answer yes or no." ;;
		esac
	done
}

run() {
	"$@" >/dev/null 2>&1
	local exit_code=$?

	if [ $exit_code -eq 0 ]; then
		printf "${green} ✓${reset}\n"
	else
		printf "${red} ✗${reset}\n"
	fi

	return $exit_code
}

clone_repo() {
	local repo_url="$1"
	local target_path="$2"

	if [ -z "$target_path" ]; then
		run git clone "$repo_url"
	else
		[ -d "$target_path" ] && rm -rf "$target_path"
        run git clone "$repo_url" "$target_path"
    fi
}

install_appimage() {
	local expected_version="$1"
	local download_url="$2"
	local appimage_path="$3"
	local appimage_file="$appimage_path/$(basename "$download_url")"

	local current_version="none"
	[ -f "$appimage_file" ] && current_version=$("$appimage_file" --appimage-version 2>&1)

	if [ "$current_version" != "$expected_version" ]; then
		sudo mkdir -p "$appimage_path"
		sudo wget -O "$appimage_file" "$download_url" >/dev/null 2>&1
		sudo chmod +x "$appimage_file"
	fi

	run test -f "$appimage_file"
}

add_ppas() {

	if [ "$dev_env" -eq 1 ]; then

		# love2d
		printf "love2d (PPA)"
		run sudo add-apt-repository -y ppa:bartbes/love-stable

	fi

	if [ "$three_d" -eq 1 ]; then

		# freecad
		printf "freecad (PPA)"
		run sudo add-apt-repository -y ppa:freecad-maintainers/freecad-stable

	fi

	if [ "$utilities" -eq 1 ]; then

		# obs
		printf "obs (PPA)"
		run sudo add-apt-repository -y ppa:obsproject/obs-studio

		# peek
		printf "peek (PPA)"
		run sudo add-apt-repository -y ppa:peek-developers/stable

	fi

	if [ "$misc" -eq 1 ]; then

		# kicad
		printf "kicad (PPA)"
		run sudo add-apt-repository -y ppa:kicad/kicad-8.0-releases

		# steam
		printf "multiverse (PPA for steam)"
		run sudo add-apt-repository -y multiverse

	fi

}

update_apt() {
	sudo apt update
	sudo apt install -f --fix-missing
	sudo apt upgrade -y
}

update_snap() {
	if ! snap list | grep -q core; then
    	sudo snap install core
	fi
	sudo snap refresh
}

install_dependencies() {

	# flatpak
	printf "flatpak"
	run sudo apt install -y flatpak
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	# pip
	printf "pip"
	run sudo apt install -y python3-pip

	# docker
	printf "docker"
	run sudo snap install docker --classic

	if [ "$dev_env" -eq 1 ]; then

		# tpm (for tmux)
		printf "tpm (for tmux)"
		clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

		# xsel (for tmux-yank)
		printf "xsel (for tmux)"
		run sudo apt install -y xsel

	fi

	if [ "$typescript" -eq 1 ]; then

		# chromium (for puppeteer)
		printf "chromium (for puppeteer)"
		run sudo apt install -y chromium-browser

	fi

}

install_software() {

	if [ "$dev_env" -eq 1 ]; then

		# btop
		printf "btop"
		run sudo apt install -y btop

		# curl
		printf "curl"
		run sudo apt install -y curl

		# dotnet-sdk
		printf "dotnet-sdk"
		run sudo apt install -y dotnet-sdk-8.0

		# g++
		printf "g++"
		run sudo apt install -y g++

		# godot
		printf "godot"
		run sudo flatpak install -y flathub org.godotengine.Godot

		# gparted
		printf "gparted"
		run sudo apt install -y gparted

		# love2d
		printf "love2d"
		run sudo apt install -y love

		# lua
		printf "lua"
		run sudo apt install -y lua5.3

		# midnight-commander
		printf "midnight-commander"
		run sudo apt install -y mc

		# neofetch
		printf "neofetch"
		run sudo apt install -y neofetch

		# neovide
		printf "neovide"
		install_appimage \
			"Version: 5735cc5" \
			"https://github.com/neovide/neovide/releases/latest/download/neovide.AppImage" \
			"/opt/neovide"

		# tmux
		printf "tmux"
		run sudo apt install -y tmux

		# tree
		printf "tree"
		run sudo apt install -y tree

		# vim
		printf "vim"
		run sudo apt install -y vim

	fi

	if [ "$typescript" -eq 1 ]; then

		# nodejs
		printf "nodejs\n"
		if ! command -v node >/dev/null 2>&1; then
			wget -qO- https://deb.nodesource.com/setup_current.x | sudo -E bash - && sudo apt install -y nodejs
		fi

		# chai
		printf "chai"
		run npm install chai @types/chai --save-dev

		# mocha
		printf "mocha"
		run npm install mocha @types/mocha --save-dev

		# puppeteer
		printf "puppeteer"
		run npm install puppeteer --save-dev

		# typescript
		printf "typescript"
		run npm install typescript @types/node --save-dev

	fi

	if [ "$three_d" -eq 1 ]; then

		# blender
		printf "blender"
		run sudo snap install blender --classic

		# freecad
		printf "freecad"
		run sudo apt install -y freecad

		# openscad
		printf "openscad"
		run sudo apt install -y openscad

		# prusaslicer
		printf "prusaslicer"
		run sudo flatpak install -y flathub com.prusa3d.PrusaSlicer

	fi

	if [ "$utilities" -eq 1 ]; then

		# deluge
		printf "deluge"
		run sudo apt install -y deluge

		# ffmpeg
		printf "ffmpeg"
		run sudo apt install -y ffmpeg

		# flameshot
		printf "flameshot"
		run sudo apt install -y flameshot

		# inkscape
		printf "inkscape"
		run sudo apt install -y inkscape

		# libreoffice
		printf "libreoffice"
		run sudo apt install -y libreoffice

		# obs
		printf "obs"
		run sudo apt install -y obs-studio

		# peek
		printf "peek"
		run sudo apt install -y peek

		# virtualbox
		printf "virtualbox"
		run sudo apt install -y virtualbox virtualbox-ext-pack

		# vlc
		printf "vlc"
		run sudo apt install -y vlc

		# yt-dlp
		printf "yt-dlp"
    	run pip3 install --upgrade yt-dlp --quiet --no-input

	fi

	if [ "$misc" -eq 1 ]; then

		# kicad
		printf "kicad"
		run sudo apt install -y kicad

		# proton-mail
		printf "proton-mail"
		run sudo snap install proton-mail

		# slack
		printf "slack"
		run sudo snap install slack

		# spotify
		printf "spotify"
		run sudo snap install spotify

		# steam
		printf "steam"
		run sudo apt install -y steam

		# telegram
		printf "telegram"
		run sudo snap install telegram-desktop

		# vivaldi
		printf "vivaldi"
		run sudo snap install vivaldi

	fi

	# cura
	printf "cura"
	install_appimage \
		"Version: 5735cc5" \
		"https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage" \
		"/opt/cura"

	# balenaEtcher
	printf "balenaEtcher"

	install_appimage \
		"Version: effcebc" \
		"https://github.com/balena-io/etcher/releases/download/v1.18.0/balenaEtcher-1.18.0-x64.AppImage" \
		"/opt/balenaEtcher"

}

install_themes() {

	if [ "$dev_env" -eq 1 ]; then

		# dracula (for midnight-commander)
		printf "dracula (for midnight-commander)"
		DRACULA_MC_PATH="$HOME/dracula-mc-theme"
		clone_repo "https://github.com/dracula/midnight-commander.git" "$DRACULA_MC_PATH"
		mkdir -p "$HOME/.local/share/mc/skins"
		ln -sf "$DRACULA_MC_PATH/skins/dracula256.ini" "$HOME/.local/share/mc/skins"

		# gruvbox (for vim)
		printf "gruvbox (for vim)"
		clone_repo "https://github.com/morhetz/gruvbox.git" "$HOME/.vim/pack/themes/start/gruvbox"

	fi

	if [ "$three_d" -eq 1 ]; then

		# dracula (for openscad)
		printf "dracula (for openscad)"
		DRACULA_OPENSCAD_PATH="$HOME/dracula-openscad-theme"
		clone_repo "https://github.com/dracula/openscad.git" "$DRACULA_OPENSCAD_PATH"
		mkdir -p "$HOME/.config/OpenSCAD/color-schemes/editor" "$HOME/.config/OpenSCAD/color-schemes/render"
		ln -sf "$DRACULA_OPENSCAD_PATH/openscad/dracula.json" "$HOME/.config/OpenSCAD/color-schemes/editor"
		ln -sf "$DRACULA_OPENSCAD_PATH/openscad/transylvania.json" "$HOME/.config/OpenSCAD/color-schemes/render"

	fi

	if [ "$misc" -eq 1 ]; then

		# dracula (for telegram)
		printf "dracula (for telegram)"
		clone_repo "https://github.com/dracula/telegram.git" "$HOME/dracula-telegram-theme"

	fi

}

cleanup() {

	sudo apt autoclean >/dev/null
	sudo apt autoremove -y >/dev/null

}

sudo -v

category="Dev Environment"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- btop"
echo "- curl"
echo "- dotnet-sdk"
echo "- g++"
echo "- godot"
echo "- gparted"
echo "- love2d"
echo "- lua"
echo "- midnight-commander"
echo "- neofetch"
echo "- neovide"
echo "- tmux"
echo "- tree"
echo "- vim"
dev_env=$(ask_install "${category}" "yes"; echo $?)

category="TypeScript"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- chai"
echo "- mocha"
echo "- nodejs"
echo "- puppeteer"
echo "- typescript"
typescript=$(ask_install "${category}" "no"; echo $?)

category="3D"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- blender"
echo "- freecad"
echo "- openscad"
echo "- prusaslicer"
three_d=$(ask_install "${category}" "no"; echo $?)

category="Utilities"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- deluge"
echo "- ffmpeg"
echo "- flameshot"
echo "- inkscape"
echo "- libreoffice"
echo "- obs"
echo "- peek"
echo "- virtualbox"
echo "- vlc"
echo "- yt-dlp"
utilities=$(ask_install "${category}" "no"; echo $?)

category="Miscellaneous"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- kicad"
echo "- proton-mail"
echo "- slack"
echo "- spotify"
echo "- steam"
echo "- telegram"
echo "- vivaldi"
misc=$(ask_install "${category}" "no"; echo $?)

printf "${yellow}${bold}"
echo "========= Add PPAs ========="
printf "${reset}"
add_ppas

printf "${yellow}${bold}"
echo "======== Update APT ========"
printf "${reset}"
run update_apt

printf "${yellow}${bold}"
echo "======= Update snap ========"
printf "${reset}"
run update_snap

printf "${yellow}${bold}"
echo "=== Install dependencies ==="
printf "${reset}"
install_dependencies

printf "${yellow}${bold}"
echo "===== Install software ====="
printf "${reset}"
install_software

printf "${yellow}${bold}"
echo "====== Install themes ======"
printf "${reset}"
install_themes

printf "${yellow}${bold}"
echo "===== Cleanup ====="
printf "${reset}"
run cleanup
