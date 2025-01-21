#!/bin/bash

install_apps() {	

  if [ "$dev_env" -eq 1 ]; then

    # bat
    printf "bat"
    check sudo apt-get install -y bat

		# btop
		printf "btop"
		check sudo apt-get install -y btop

		# dotnet-sdk
		printf "dotnet-sdk"
		check sudo apt-get install -y dotnet-sdk-8.0

		# g++
		printf "g++"
		check sudo apt-get install -y g++

		# godot
		printf "godot"
		run sudo flatpak install -y flathub org.godotengine.Godot
    check godot --version

		# gparted
		printf "gparted"
		check sudo apt-get install -y gparted

		# love2d
		printf "love2d"
		check sudo apt-get install -y love

		# lua
		printf "lua"
		check sudo apt-get install -y lua5.3

		# lunarvim
		printf "lunarvim"
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) <<< $'n\nn\nn'
    check lvim -v

    # midnight-commander
		printf "midnight-commander"
		check sudo apt-get install -y mc

		# neofetch
		printf "neofetch"
		check sudo apt-get install -y neofetch

		# thefuck
		printf "thefuck"
		check pipx install thefuck

		# tmux
		printf "tmux"
		check sudo apt-get install -y tmux

		# tree
		printf "tree"
		check sudo apt-get install -y tree

		# vim
		printf "vim"
		check sudo apt-get install -y vim

    if [ "$cargo" -eq 1 ]; then

      # eza
      printf "eza"
      check cargo install eza

      # zoxide
      printf "zoxide"
      check cargo install zoxide --locked

    fi

    if [ "$homebrew" -eq 1 ]; then

      # fzf
      printf "fzf"
      check brew install fzf

    fi

    if [ "$nodejs" -eq 1 ]; then

      # chai
      printf "chai"
      check sudo npm install chai @types/chai --save-dev

      # mocha
      printf "mocha"
      check sudo npm install mocha @types/mocha --save-dev

      # puppeteer
      printf "puppeteer"
      check sudo npm install puppeteer --save-dev

      # typescript
      printf "typescript"
      check sudo npm install typescript @types/node --save-dev

    fi

  fi

  if [ "$hyprland" -eq 1 ]; then

    # hyprlock
    printf "hyprlock"
    HYPRLOCK_PATH="$HYPRLAND_PATH/hyprlock"
    clone_repo "https://github.com/hyprwm/hyprlock.git" "$HYPRLOCK_PATH"
    run cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S "$HYPRLOCK_PATH" -B "$HYPRLOCK_PATH/build"
    run cmake --build "$HYPRLOCK_PATH/build" --config Release --target hyprlock -j$(nproc)
    run cmake --install "$HYPRLOCK_PATH/build"
    check hyprlock

    # hyprpaper
    printf "hyprpaper\n"
    HYPRPAPER_PATH="$HYPRLAND_PATH/hyprpaper"
    clone_repo "https://github.com/hyprwm/hyprpaper.git" "$HYPRPAPER_PATH"
    run cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S "$HYPRPAPER_PATH" -B "$HYPRPAPER_PATH/build"
    run cmake --build "$HYPRPAPER_PATH/build" --config Release --target hyprpaper -j$(nproc)
    run sudo cmake --install "$HYPRPAPER_PATH/build"
    rm -f "$ERR_FILE"

    # hyprshot
    printf "hyprshot"
    HYPRSHOT_REPO_PATH="$HYPRLAND_PATH/hyprshot"
    HYPRSHOT_BIN_PATH="$HOME/.local/bin/hyprshot"
    clone_repo "https://github.com/Gustash/Hyprshot.git" "$HYPRSHOT_REPO_PATH"
    run ln -sf "$HYPRSHOT_REPO_PATH/hyprshot" "$HYPRSHOT_BIN_PATH"
    run chmod +x "$HYPRSHOT_REPO_PATH/hyprshot"
    check hyprshot

    # rofi
    printf "rofi"
    ROFI_PATH="$HYPRLAND_PATH/rofi"
    clone_repo "https://github.com/in0ni/rofi-wayland.git" "$ROFI_PATH"
    run meson setup "$ROFI_PATH" "$ROFI_PATH/build"
    run meson compile -C "$ROFI_PATH/build"
    run sudo meson install -C "$ROFI_PATH/build"
    check rofi -v

    # sway-notification-center
    printf "sway-notification-center"
    check sudo apt-get install -y sway-notification-center

    # waybar
    printf "waybar"
    check sudo apt-get install -y waybar

  fi

  if [[ "$dev_env" -eq 1 || "$hyprland" -eq 1 ]]; then

    # alacritty
    printf "alacritty"
    check sudo snap install alacritty --classic

  fi

	if [ "$three_d" -eq 1 ]; then

		# blender
		printf "blender"
		check sudo snap install blender --classic

    # cura
    printf "cura"
    install_appimage \
      "Version: 5735cc5" \
      "https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage" \
      "/opt/cura"

		# freecad
		printf "freecad"
		check sudo apt-get install -y freecad

		# openscad
		printf "openscad"
		check sudo apt-get install -y openscad

		# prusaslicer
		printf "prusaslicer"
		check sudo flatpak install -y flathub com.prusa3d.PrusaSlicer

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
		check sudo apt-get install -y deluge

		# ffmpeg
		printf "ffmpeg"
		check sudo apt-get install -y ffmpeg

		# flameshot
		printf "flameshot"
		check sudo apt-get install -y flameshot

		# gimp
    printf "gimp"
    check sudo apt-get install -y gimp

		# inkscape
		printf "inkscape"
		check sudo apt-get install -y inkscape

		# kicad
		printf "kicad"
		check sudo apt-get install -y kicad

		# libreoffice
		printf "libreoffice"
		check sudo apt-get install -y libreoffice

		# obs
		printf "obs"
		check sudo apt-get install -y obs-studio

		# peek
		printf "peek"
		check sudo apt-get install -y peek

		# virtualbox
		printf "virtualbox"
		check sudo apt-get install -y virtualbox
		# sudo apt-get install virtualbox-ext-pack

		# vlc
		printf "vlc"
		check sudo apt-get install -y vlc

		# yt-dlp
		printf "yt-dlp"
		check pipx install yt-dlp --quiet

	fi

	if [ "$misc" -eq 1 ]; then

		# proton-mail
		printf "proton-mail"
		check sudo snap install proton-mail

		# slack
		printf "slack"
		check sudo snap install slack

		# spotify
		printf "spotify"
		check sudo snap install spotify

		# steam
		printf "steam"
		check sudo snap install steam

		# telegram
		printf "telegram"
		check sudo snap install telegram-desktop

		# vivaldi
		printf "vivaldi"
		check sudo snap install vivaldi

	fi

}
