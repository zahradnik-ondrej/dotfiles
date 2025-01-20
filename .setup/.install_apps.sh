#!/bin/bash

install_apps() {	

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
