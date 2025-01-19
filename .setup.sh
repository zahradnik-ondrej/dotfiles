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
    return 1
	else
		printf "${red} ✗${reset}\n"
    return 0
	fi
}

clone_repo() {
	local repo_url="$1"
	local target_path="$2"

	if [ -z "$target_path" ]; then
    target_path=$(basename -s .git "$repo_url")
  fi

  [ -e "$target_path" ] && rm -rf "$target_path"
  git clone -q "$repo_url" "$target_path"
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

  # multiverse
  printf "multiverse (PPA)"
  run sudo add-apt-repository -y multiverse

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

	fi

}

update_apt() {
	sudo apt-get update
	sudo apt-get install -f --fix-missing
	sudo apt-get upgrade -y
}

update_snap() {
	if ! snap list | grep -q core; then
    sudo snap install core
	fi
	sudo snap refresh
}

install_dependencies() {

	# build-essential
	printf "build-essential"
	run sudo apt-get install -y build-essential

	# cargo
	printf "cargo"
	run bash -c 'wget -qO- https://sh.rustup.rs | sh -s -- -y && . "$HOME/.bashrc"'
  cargo=$?

  # cmake
  printf "cmake"
  run sudo apt-get install -y cmake

	# curl
	printf "curl"
	run sudo apt-get install -y curl

	# docker
	printf "docker"
	run sudo snap install docker --classic

	# flatpak
	printf "flatpak"
	run sudo apt-get install -y flatpak
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  # meson
  printf "meson"
  run sudo apt-get install -y meson

  # nodejs
  printf "nodejs\n"
  wget -qO- https://deb.nodesource.com/setup_current.x | sudo -E bash - && sudo apt-get install -y nodejs
  nodejs=$?

  # pip3
  printf "pip3"
  run sudo apt-get install -y python3-pip

	# pipx
	printf "pipx"
	run sudo apt-get install -y pipx

  # setuptools
  printf "setuptools"
  run pip3 install --upgrade setuptools --break-system-packages

	# homebrew
	# printf "homebrew"
	# HOMEBREW_INSTALL_SCRIPT_PATH="$HOME/install.sh"
	# run bash -c 'wget -qO "$HOMEBREW_INSTALL_SCRIPT_PATH" https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh && NONINTERACTIVE=1 /bin/bash "$HOMEBREW_INSTALL_SCRIPT_PATH" && rm -f "$HOMEBREW_INSTALL_SCRIPT_PATH"'
  # homebrew=$?

	if [ "$dev_env" -eq 1 ]; then

    # black
    printf "black"
    run sudo apt-get install -y black

    # libtmux (for tmux)
    printf "libtmux (for tmux)"
    run pip3 install libtmux --break-system-packages

		# neovim (for lunarvim)
		printf "neovim (for lunarvim)\n"
		NEOVIM_ARCHIVE_PATH="$HOME/nvim-linux64.tar.gz"
		[ -f "$NEOVIM_ARCHIVE_PATH" ] && rm -f "$NEOVIM_ARCHIVE_PATH"
		wget -qO "$NEOVIM_ARCHIVE_PATH" https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
		sudo rm -rf /opt/nvim
		sudo tar -C /opt -xzf nvim-linux64.tar.gz
    rm -r "$NEOVIM_ARCHIVE_PATH"

    # neovim-remote (for lunarvim)
    printf "neovim-remote (for lunarvim)"
    run pipx install neovim-remote

		# pynvim (for lunarvim)
		printf "pynvim (for lunarvim)"
		run pip install --break-system-packages pynvim

    # ripgrep (for lunarvim)
    printf "ripgrep (for lunarvim)"
    run sudo apt-get install -y ripgrep

		# tpm (for tmux)
		printf "tpm (for tmux)\n"
		clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

    # vim-tmux-cycle (for tmux)
    printf "vim-tmux-cycle (for tmux)"
    VIM_TMUX_CYCLE_REPO_PATH="$HOME/.vim-tmux-cycle"
    VIM_TMUX_CYCLE_BIN_PATH="/usr/local/bin"
    run bash -c "clone_repo 'https://github.com/slarwise/vim-tmux-cycle' \"\$VIM_TMUX_CYCLE_REPO_PATH\" && sudo mv \"\$VIM_TMUX_CYCLE_REPO_PATH/vim-tmux-cycle\" \"\$VIM_TMUX_CYCLE_BIN_PATH\" && chmod +x \"\$VIM_TMUX_CYCLE_BIN_PATH/vim-tmux-cycle\""

		# xsel (for tmux-yank)
		printf "xsel (for tmux)"
		run sudo apt-get install -y xsel

    # if [ "$homebrew" -eq 1 ]; then
      # lazygit (for lunarvim)
      printf "lazygit (for lunarvim)"
      run brew install jesseduffield/lazygit/lazygit
      
      # oh-my-posh
      printf "oh-my-posh"
      run brew install oh-my-posh
    # fi

	fi

  if [[ "$dev_env" -eq 1 || "$hyprland" -eq 1 ]]; then
    
    # libfontconfig1-dev (for alacritty)
    printf "libfontconfig1-dev (for alacritty)"
    run sudo apt-get install -y libfontconfig1-dev

  fi

	if [ "$hyprland" -eq 1 ]; then

    HYPRLAND_PATH="$HOME/.hyprland"
    mkdir -p "$HYPRLAND_PATH"

    # hyprland
    printf "hyprland"
    run sudo apt-get install -y hyprland
    hyprland=$?

    # libpugixml-dev (for hyprwayland-scanner)
    printf "libpugixml-dev (for hyprwayland-scanner)"
    run sudo apt-get install -y libpugixml-dev

    # hyprwayland-scanner
    printf "hyprwayland-scanner\n"
    HYPRWAYLANDSCANNER_PATH="$HYPRLAND_PATH/hyprwayland-scanner"
    clone_repo "https://github.com/hyprwm/hyprwayland-scanner.git" "$HYPRWAYLANDSCANNER_PATH"
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE=Release -S "$HYPRWAYLANDSCANNER_PATH" -B "$HYPRWAYLANDSCANNER_PATH/build"
    cmake --build "$HYPRWAYLANDSCANNER_PATH/build" --config Release -j$(nproc)
    sudo cmake --install "$HYPRWAYLANDSCANNER_PATH/build"

    # hyprlock (dependencies)
    printf "hyprlock (dependencies)"
    run sudo apt-get install -y libegl1-mesa-dev libgles2-mesa-dev libopengl-dev libxkbcommon-dev libjpeg-dev libwebp-dev libmagic-dev libcairo2-dev libpango1.0-dev libdrm-dev libgbm-dev libsdbus-c++-dev libwayland-dev wayland-protocols libpam0g-dev

    # sdbus-cpp (for hyprlock)
    printf "sdbus-cpp (for hyprlock)\n"
    SDBUSCPP_PATH="$HYPRLAND_PATH/sdbus-cpp"
    clone_repo "https://github.com/Kistler-Group/sdbus-cpp.git" "$SDBUSCPP_PATH"
    mkdir -p "$SDBUSCPP_PATH/build"
    cmake -S "$SDBUSCPP_PATH" -B "$SDBUSCPP_PATH/build"
    make -C "$SDBUSCPP_PATH/build"
    sudo make -C "$SDBUSCPP_PATH/build" install

    # hyprutils
    printf "hyprutils\n"
    HYPRUTILS_PATH="$HYPRLAND_PATH/hyprutils"
    clone_repo "https://github.com/hyprwm/hyprutils.git" "$HYPRUTILS_PATH"
    mkdir -p "$HYPRLAND_PATH/hyprutils/build"
    cmake "$HYPRLAND_PATH/hyprutils" -B "$HYPRLAND_PATH/hyprutils/build"
    make -C "$HYPRLAND_PATH/hyprutils/build"
    sudo make -C "$HYPRLAND_PATH/hyprutils/build" install

    # hyprgraphics (for hyprlock)
    printf "hyprgraphics (for hyprlock)\n"
    HYPRGRAPHICS_PATH="$HYPRLAND_PATH/hyprgraphics"
    clone_repo "https://github.com/hyprwm/hyprgraphics.git" "$HYPRGRAPHICS_PATH"
    mkdir -p "$HYPRLAND_PATH/hyprgraphics/build"
    cmake "$HYPRLAND_PATH/hyprgraphics" -B "$HYPRLAND_PATH/hyprgraphics/build"
    make -C "$HYPRLAND_PATH/hyprgraphics/build"
    sudo make -C "$HYPRLAND_PATH/hyprgraphics/build" install

    # hyprlang (for hyprlock)
    printf "hyprlang (for hyprlock)\n"
    HYPRLANG_PATH="$HYPRLAND_PATH/hyprlang"
    clone_repo "https://github.com/hyprwm/hyprlang.git" "$HYPRLANG_PATH"
    mkdir -p "$HYPRLAND_PATH/hyprlang/build"
    cmake "$HYPRLAND_PATH/hyprlang" -B "$HYPRLAND_PATH/hyprlang/build"
    make -C "$HYPRLAND_PATH/hyprlang/build"
    sudo make -C "$HYPRLAND_PATH/hyprlang/build" install

    # rofi (dependencies)
    printf "rofi (dependencies)"
    run sudo apt-get install -y libgdk-pixbuf-2.0-dev libxcb-util-dev libxcb-xkb-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-cursor-dev libxcb-xinerama0-dev libstartup-notification0-dev flex bison

    # slurp (for hyprshot)
    printf "slurp (for hyprshot)"
    run sudo apt-get install -y slurp

    # wl-clipboard (for hyprshot)
    printf "wl-clipboard (for hyprshot)"
    run sudo apt-get install -y wl-clipboard

  fi

	if [ "$typescript" -eq 1 ]; then

		# chromium (for puppeteer)
		printf "chromium (for puppeteer)"
		run sudo apt-get install -y chromium-browser

	fi

}

install_software() {	

  if [ "$dev_env" -eq 1 ]; then

    # bat
    printf "bat"
    run sudo apt-get install -y bat

		# btop
		printf "btop"
		run sudo apt-get install -y btop

		# dotnet-sdk
		printf "dotnet-sdk"
		run sudo apt-get install -y dotnet-sdk-8.0

		# g++
		printf "g++"
		run sudo apt-get install -y g++

		# godot
		printf "godot"
		run sudo flatpak install -y flathub org.godotengine.Godot

		# gparted
		printf "gparted"
		run sudo apt-get install -y gparted

		# love2d
		printf "love2d"
		run sudo apt-get install -y love

		# lua
		printf "lua"
		run sudo apt-get install -y lua5.3

		# lunarvim
		printf "lunarvim"
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) <<< $'n\nn\nn'

    # midnight-commander
		printf "midnight-commander"
		run sudo apt-get install -y mc

		# neofetch
		printf "neofetch"
		run sudo apt-get install -y neofetch

		# thefuck
		printf "thefuck"
		run pipx install thefuck

		# tmux
		printf "tmux"
		run sudo apt-get install -y tmux

		# tree
		printf "tree"
		run sudo apt-get install -y tree

		# vim
		printf "vim"
		run sudo apt-get install -y vim

    # if [ "$homebrew" -eq 1 ]; then

      # fzf
      printf "fzf"
      run brew install fzf

    # fi

    if [ "$cargo" -eq 1 ]; then

      # eza
      printf "eza"
      run cargo install eza

      # zoxide
      printf "zoxide"
      run cargo install zoxide --locked

    fi

  fi

  if [ "$hyprland" -eq 1 ]; then

    # hyprlock
    printf "hyprlock\n"
    HYPRLOCK_PATH="$HYPRLAND_PATH/hyprlock"
    clone_repo "https://github.com/hyprwm/hyprlock.git" "$HYPRLOCK_PATH"
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S "$HYPRLOCK_PATH" -B "$HYPRLOCK_PATH/build"
    cmake --build "$HYPRLOCK_PATH/build" --config Release --target hyprlock -j$(nproc)
    sudo cmake --install "$HYPRLOCK_PATH/build"

    # hyprpaper
    printf "hyprpaper\n"
    HYPRPAPER_PATH="$HYPRLAND_PATH/hyprpaper"
    clone_repo "https://github.com/hyprwm/hyprpaper.git" "$HYPRPAPER_PATH"
    cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S "$HYPRPAPER_PATH" -B "$HYPRPAPER_PATH/build"
    cmake --build "$HYPRPAPER_PATH/build" --config Release --target hyprpaper -j$(nproc)
    sudo cmake --install "$HYPRPAPER_PATH/build"

    # hyprshot
    printf "hyprshot\n"
    HYPRSHOT_REPO_PATH="$HYPRLAND_PATH/hyprshot"
    HYPRSHOT_BIN_PATH="$HOME/.local/bin/hyprshot"
    clone_repo "https://github.com/Gustash/Hyprshot.git" "$HYPRSHOT_REPO_PATH"
    ln -sf "$HYPRSHOT_REPO_PATH/hyprshot" "$HYPRSHOT_BIN_PATH"
    chmod +x "$HYPRSHOT_REPO_PATH/hyprshot"

    # rofi
    printf "rofi\n"
    ROFI_PATH="$HYPRLAND_PATH/rofi-wayland"
    clone_repo "https://github.com/in0ni/rofi-wayland.git" "$ROFI_PATH"
    meson setup "$ROFI_PATH" "$ROFI_PATH/build"
    meson compile -C "$ROFI_PATH/build"
    sudo meson install -C "$ROFI_PATH/build"

    # sway-notification-center
    printf "sway-notification-center"
    run sudo apt-get install -y sway-notification-center

    # waybar
    printf "waybar"
    run sudo apt-get install -y waybar

  fi

  if [[ "$dev_env" -eq 1 || "$hyprland" -eq 1 ]]; then

    # alacritty
    printf "alacritty"
    run sudo snap install alacritty --classic

  fi

	if [ "$typescript" -eq 1 ]; then

    if [ "$nodejs" -eq 1 ]; then

      # chai
      printf "chai"
      sudo npm install chai @types/chai --save-dev

      # mocha
      printf "mocha"
      run sudo npm install mocha @types/mocha --save-dev

      # puppeteer
      printf "puppeteer"
      run sudo npm install puppeteer --save-dev

      # typescript
      printf "typescript"
      run sudo npm install typescript @types/node --save-dev

    fi

	fi

	if [ "$three_d" -eq 1 ]; then

		# blender
		printf "blender"
		run sudo snap install blender --classic

    # cura
    printf "cura"
    install_appimage \
      "Version: 5735cc5" \
      "https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage" \
      "/opt/cura"

		# freecad
		printf "freecad"
		run sudo apt-get install -y freecad

		# openscad
		printf "openscad"
		run sudo apt-get install -y openscad

		# prusaslicer
		printf "prusaslicer"
		run sudo flatpak install -y flathub com.prusa3d.PrusaSlicer

	fi

	if [ "$utilities" -eq 1 ]; then

    # balenaEtcher
    printf "balenaEtcher"
    install_appimage \
      "Version: effcebc" \
      "https://github.com/balena-io/etcher/releases/download/v1.18.0/balenaEtcher-1.18.0-x64.AppImage" \
      "/opt/balenaEtcher"

		# deluge
		printf "deluge"
		run sudo apt-get install -y deluge

		# ffmpeg
		printf "ffmpeg"
		run sudo apt-get install -y ffmpeg

		# flameshot
		printf "flameshot"
		run sudo apt-get install -y flameshot

		# gimp
    printf "gimp"
    run sudo apt-get install -y gimp

		# inkscape
		printf "inkscape"
		run sudo apt-get install -y inkscape

		# kicad
		printf "kicad"
		run sudo apt-get install -y kicad

		# libreoffice
		printf "libreoffice"
		run sudo apt-get install -y libreoffice

		# obs
		printf "obs"
		run sudo apt-get install -y obs-studio

		# peek
		printf "peek"
		run sudo apt-get install -y peek

		# virtualbox
		printf "virtualbox"
		run sudo apt-get install -y virtualbox
		# sudo apt-get install virtualbox-ext-pack

		# vlc
		printf "vlc"
		run sudo apt-get install -y vlc

		# yt-dlp
		printf "yt-dlp"
		run pipx install yt-dlp --quiet

	fi

	if [ "$misc" -eq 1 ]; then

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
		run sudo snap install steam

		# telegram
		printf "telegram"
		run sudo snap install telegram-desktop

		# vivaldi
		printf "vivaldi"
		run sudo snap install vivaldi

	fi

}

install_themes() {

	THEMES_PATH="$HOME/.themes"
	mkdir -p "$THEMES_PATH"

	if [ "$dev_env" -eq 1 ]; then

		# dracula (for midnight-commander)
		printf "dracula (for midnight-commander)\n"
		MC_DRACULA_PATH="$THEMES_PATH/mc-dracula"
    MC_THEMES_PATH="$HOME/.local/share/mc/skins"
		clone_repo "https://github.com/dracula/midnight-commander.git" "$MC_DRACULA_PATH"
		mkdir -p "$MC_THEMES_PATH"
		ln -sf "$MC_DRACULA_PATH/skins/dracula256.ini" "$MC_THEMES_PATH"

		# gruvbox (for vim)
		printf "gruvbox (for vim)\n"
    VIM_GRUVBOX_PATH="$THEMES_PATH/vim-gruvbox"
		VIM_THEMES_PATH="$HOME/.vim/pack/themes/start"
		clone_repo "https://github.com/morhetz/gruvbox.git" "$VIM_GRUVBOX_PATH"
		mkdir -p "$VIM_THEMES_PATH"
    ln -sf "$VIM_GRUVBOX_PATH" "$HOME/.vim/pack/themes/start/gruvbox"

	fi

  if [[ "$dev_env" -eq 1 || "$hyprland" -eq 1 ]]; then

		# dracula (for alacritty)
		printf "dracula (for alacritty)"
		ALACRITTY_DRACULA_PATH="$THEMES_PATH/alacritty-dracula"
		run clone_repo "https://github.com/dracula/alacritty.git" "$ALACRITTY_DRACULA_PATH"

  fi

	if [ "$hyprland" -eq 1 ]; then

    # dracula (for rofi)
    printf "dracula (for rofi)\n"
    ROFI_DRACULA_PATH="$THEMES_PATH/rofi-dracula"
    ROFI_THEMES_PATH="$HOME/.config/rofi"
    clone_repo "https://github.com/dracula/rofi.git" "$ROFI_DRACULA_PATH"
    mkdir -p "$ROFI_THEMES_PATH"
    ln -sf "$ROFI_DRACULA_PATH/theme/config1.rasi" "$ROFI_THEMES_PATH/config.rasi"

  fi

	if [ "$three_d" -eq 1 ]; then

		# dracula (for openscad)
		printf "dracula (for openscad)\n"
		OPENSCAD_DRACULA_PATH="$THEMES_PATH/openscad-dracula"
    OPENSCAD_THEMES_PATH="$HOME/.config/OpenSCAD/color-schemes"
		clone_repo "https://github.com/dracula/openscad.git" "$OPENSCAD_DRACULA_PATH"
		mkdir -p "$OPENSCAD_THEMES_PATH/editor" "$OPENSCAD_THEMES_PATH/render"
		ln -sf "$OPENSCAD_DRACULA_PATH/openscad/dracula.json" "$OPENSCAD_THEMES_PATH/editor"
		ln -sf "$OPENSCAD_DRACULA_PATH/openscad/transylvania.json" "$OPENSCAD_THEMES_PATH/render"

	fi

	if [ "$utilities" -eq 1 ]; then

    # dracula (for gimp)
    printf "dracula (for gimp)\n"
    GIMP_DRACULA_PATH="$THEMES_PATH/gimp-dracula"
    GIMP_THEMES_PATH="$HOME/.config/GIMP/2.10/themes"
    clone_repo "https://github.com/dracula/gimp.git" "$GIMP_DRACULA_PATH"
    mkdir -p "$GIMP_THEMES_PATH"
    ln -sf "$GIMP_DRACULA_PATH/Dracula" "$GIMP_THEMES_PATH/Dracula"

	fi

	if [ "$misc" -eq 1 ]; then

		# dracula (for telegram)
		printf "dracula (for telegram)"
    TELEGRAM_DRACULA_PATH="$THEMES_PATH/telegram-dracula"
		run clone_repo "https://github.com/dracula/telegram.git" "$TELEGRAM_DRACULA_PATH"

	fi

}

install_fonts() {

	FONTS_PATH="$HOME/.local/share/fonts"

	if [ "$dev_env" -eq 1 ]; then

		# hack nerd font
		printf "hack nerd font\n"
		HACK_NERD_FONT_ARCHIVE_PATH="$HOME/Hack.zip"
		[ -f "$HACK_NERD_FONT_ARCHIVE_PATH" ] && rm -f "$HACK_NERD_FONT_ARCHIVE_PATH"
		wget -qO "$HACK_NERD_FONT_ARCHIVE_PATH" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
		mkdir -p "$FONTS_PATH"
		unzip -oq "$HACK_NERD_FONT_ARCHIVE_PATH" -d "$FONTS_PATH"
    rm -r "$HACK_NERD_FONT_ARCHIVE_PATH"

	fi

  fc-cache -f

}

cleanup() {

	sudo apt-get autoclean >/dev/null
	sudo apt-get autoremove -y >/dev/null

}

sudo -v

category="Dev Environment"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- alacritty"
echo "- bat"
echo "- btop"
echo "- eza"
echo "- dotnet-sdk"
echo "- g++"
echo "- godot"
echo "- gparted"
echo "- love2d"
echo "- lua"
echo "- lunarvim"
echo "- midnight-commander"
echo "- neofetch"
echo "- neovide"
echo "- thefuck"
echo "- tmux"
echo "- tree"
echo "- vim"
echo "- zoxide"
dev_env=$(ask_install "${category}" "yes"; echo $?)

category="Hyprland"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- hyprland"
echo "- hyprlock"
echo "- hyprpaper"
echo "- hyprshot"
echo "- rofi"
echo "- sway-notification-center"
echo "- waybar"
hyprland=$(ask_install "${category}" "no"; echo $?)

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
echo "- cura"
echo "- freecad"
echo "- openscad"
echo "- prusaslicer"
three_d=$(ask_install "${category}" "no"; echo $?)

category="Utilities"
printf "${cyan}${bold}"
printf "❏ ${category}\n"
printf "${reset}"
echo "- balena-etcher"
echo "- deluge"
echo "- ffmpeg"
echo "- flameshot"
echo "- gimp"
echo "- inkscape"
echo "- kicad"
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
echo "======== Update apt ========"
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

if [ "$dev_env" -eq 1 ]; then
  printf "${yellow}${bold}"
  echo "====== Install fonts ======"
  printf "${reset}"
  install_fonts
fi

printf "${yellow}${bold}"
echo "===== Cleanup ====="
printf "${reset}"
run cleanup
