#!/bin/bash

install_dependencies() {

	# build-essential
	printf "build-essential"
	check sudo apt-get install -y build-essential

	# rustup
	printf "rustup"
  check sudo snap install rustup --classic
  rustup=$?

  # cmake
  printf "cmake"
  check sudo apt-get install -y cmake

	# curl
	printf "curl"
	check sudo apt-get install -y curl

	# docker
	printf "docker"
	check sudo snap install docker --classic

	# flatpak
	printf "flatpak"
  check bash -c "sudo apt-get install -y flatpak && sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo"
  
  # go
  printf "go"
  check sudo snap install go --classic

  # meson
  printf "meson"
  check sudo apt-get install -y meson

  # nodejs
  printf "nodejs"
  check sudo snap install node --classic
  nodejs=$?

  # pip3
  printf "pip3"
  check sudo apt-get install -y python3-pip

	# pipx
	printf "pipx"
	check sudo apt-get install -y pipx

  # setuptools
  printf "setuptools"
  check pip3 install --upgrade setuptools --break-system-packages

	# homebrew
	printf "homebrew"
	HOMEBREW_PATH="$HOME/install.sh"
  wget -qO "$HOMEBREW_PATH" https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
  NONINTERACTIVE=1 /bin/bash "$HOMEBREW_PATH"
  run rm -f "$HOMEBREW_PATH"
  check brew
  homebrew=$?

	if [ "$dev_env" -eq 1 ]; then

    # black
    printf "black"
    check sudo apt-get install -y black

		# chromium (for puppeteer)
		printf "chromium (for puppeteer)"
    check sudo snap install chromium

    # libtmux (for tmux)
    printf "libtmux (for tmux)"
    check pip3 install libtmux --break-system-packages

		# neovim (for lunarvim)
		printf "neovim (for lunarvim)"
		NEOVIM_ARCHIVE_PATH="$HOME/nvim-linux64.tar.gz"
		[ -f "$NEOVIM_ARCHIVE_PATH" ] && rm -f "$NEOVIM_ARCHIVE_PATH"
		run wget -qO "$NEOVIM_ARCHIVE_PATH" https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
		run sudo rm -rf /opt/nvim
		run sudo tar -C /opt -xzf nvim-linux64.tar.gz
    run rm -r "$NEOVIM_ARCHIVE_PATH"
    check nvim -v

    # neovim-remote (for lunarvim)
    printf "neovim-remote (for lunarvim)"
    check pipx install neovim-remote

		# pynvim (for lunarvim)
		printf "pynvim (for lunarvim)"
		check pip install --break-system-packages pynvim

    # ripgrep (for lunarvim)
    printf "ripgrep (for lunarvim)"
    check sudo apt-get install -y ripgrep

		# tpm (for tmux)
		printf "tpm (for tmux)\n"
		clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

    # vim-tmux-cycle (for tmux)
    printf "vim-tmux-cycle (for tmux)\n"
    VIM_TMUX_CYCLE_REPO_PATH="$HOME/.vim-tmux-cycle"
    VIM_TMUX_CYCLE_BIN_PATH="/usr/local/bin"
    clone_repo 'https://github.com/slarwise/vim-tmux-cycle' "$VIM_TMUX_CYCLE_REPO_PATH"
    run sudo mv "$VIM_TMUX_CYCLE_REPO_PATH/vim-tmux-cycle" "$VIM_TMUX_CYCLE_BIN_PATH"
    run chmod +x "$VIM_TMUX_CYCLE_BIN_PATH/vim-tmux-cycle"
    rm -f "$ERR_FILE" 

		# xsel (for tmux-yank)
		printf "xsel (for tmux)"
		check sudo apt-get install -y xsel

    if [ "$homebrew" -eq 1 ]; then

      # lazygit (for lunarvim)
      printf "lazygit (for lunarvim)"
      check brew install jesseduffield/lazygit/lazygit

      # oh-my-posh
      printf "oh-my-posh"
      check brew install oh-my-posh

    fi

	fi

  if [[ "$dev_env" -eq 1 || "$hyprland" -eq 1 ]]; then

    # alacritty (dependencies)
    printf "libfontconfig1-dev (for alacritty)"
    check sudo apt-get install -y libfontconfig1-dev

  fi

	if [ "$hyprland" -eq 1 ]; then

    HYPRLAND_PATH="$HOME/.hyprland"
    mkdir -p "$HYPRLAND_PATH"

    # # hyprcursor
    # printf "hyprcursor"
    # HYPRCURSOR_PATH="$HYPRLAND_PATH/hyprcursor"
    # clone_repo "https://github.com/hyprwm/hyprcursor.git" "$HYPRCURSOR_PATH"
    # clone_repo "https://github.com/marzer/tomlplusplus.git" "$HOME/.local/include/tomlplusplus"
    # run mv "$HOME/.local/include/tomlplusplus/"*.h "$HOME/.local/include"
    # run sed -i '/^pkg_check_modules(/s/tomlplusplus//;/^project(/a include_directories("'"$HOME"'/.local/include")' "$HYPRCURSOR_PATH/CMakeLists.txt"
    # run mkdir -p "$HYPRCURSOR_PATH/build"
    # run cmake "$HYPRCURSOR_PATH" -B "$HYPRCURSOR_PATH/build"
    # run make -C "$HYPRCURSOR_PATH/build"
    # run sudo make -C "$HYPRCURSOR_PATH/build" install
    # check hyprcursor

    # hyprland
    printf "hyprland"
    check sudo apt-get install -y hyprland
    hyprland=$?

    # nwg[dock (dependencies)
    printf "nwg-dock (dependencies)"
    check sudo apt-get install -y libgirepository1.0-dev gir1.2-gtk-4.0 libatk1.0-dev libgdk-pixbuf2.0-dev libgtk-3-dev libgtk-4-dev

    # libpugixml-dev (for hyprwayland-scanner)
    printf "libpugixml-dev (for hyprwayland-scanner)"
    check sudo apt-get install -y libpugixml-dev

    # hyprwayland-scanner
    printf "hyprwayland-scanner"
    HYPRWAYLANDSCANNER_PATH="$HYPRLAND_PATH/hyprwayland-scanner"
    clone_repo "https://github.com/hyprwm/hyprwayland-scanner.git" "$HYPRWAYLANDSCANNER_PATH"
    run cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE=Release -S "$HYPRWAYLANDSCANNER_PATH" -B "$HYPRWAYLANDSCANNER_PATH/build"
    run cmake --build "$HYPRWAYLANDSCANNER_PATH/build" --config Release -j$(nproc)
    run sudo cmake --install "$HYPRWAYLANDSCANNER_PATH/build"
    check hyprwayland-scanner -v

    # hyprutils
    printf "hyprutils"
    HYPRUTILS_PATH="$HYPRLAND_PATH/hyprutils"
    clone_repo "https://github.com/hyprwm/hyprutils.git" "$HYPRUTILS_PATH"
    run mkdir -p "$HYPRLAND_PATH/hyprutils/build"
    run cmake "$HYPRLAND_PATH/hyprutils" -B "$HYPRLAND_PATH/hyprutils/build"
    run make -C "$HYPRLAND_PATH/hyprutils/build"
    run sudo make -C "$HYPRLAND_PATH/hyprutils/build" install
    check hyprutils

    # hyprlock (dependencies)
    printf "hyprlock (dependencies)"
    check sudo apt-get install -y libegl1-mesa-dev libgles2-mesa-dev libopengl-dev libxkbcommon-dev libjpeg-dev libwebp-dev libmagic-dev libcairo2-dev libpango1.0-dev libdrm-dev libgbm-dev libsdbus-c++-dev libwayland-dev wayland-protocols libpam0g-dev

    # sdbus-cpp (for hyprlock)
    printf "sdbus-cpp (for hyprlock)"
    SDBUSCPP_PATH="$HYPRLAND_PATH/sdbus-cpp"
    clone_repo "https://github.com/Kistler-Group/sdbus-cpp.git" "$SDBUSCPP_PATH"
    run mkdir -p "$SDBUSCPP_PATH/build"
    run cmake -S "$SDBUSCPP_PATH" -B "$SDBUSCPP_PATH/build"
    run make -C "$SDBUSCPP_PATH/build"
    run sudo make -C "$SDBUSCPP_PATH/build" install
    check sdbus-cpp

    # hyprgraphics (for hyprlock)
    printf "hyprgraphics (for hyprlock)"
    HYPRGRAPHICS_PATH="$HYPRLAND_PATH/hyprgraphics"
    clone_repo "https://github.com/hyprwm/hyprgraphics.git" "$HYPRGRAPHICS_PATH"
    run mkdir -p "$HYPRLAND_PATH/hyprgraphics/build"
    run cmake "$HYPRLAND_PATH/hyprgraphics" -B "$HYPRLAND_PATH/hyprgraphics/build"
    run make -C "$HYPRLAND_PATH/hyprgraphics/build"
    run sudo make -C "$HYPRLAND_PATH/hyprgraphics/build" install
    check hyprgraphics

    # hyprlang (for hyprlock)
    printf "hyprlang (for hyprlock)"
    HYPRLANG_PATH="$HYPRLAND_PATH/hyprlang"
    clone_repo "https://github.com/hyprwm/hyprlang.git" "$HYPRLANG_PATH"
    run mkdir -p "$HYPRLAND_PATH/hyprlang/build"
    run cmake "$HYPRLAND_PATH/hyprlang" -B "$HYPRLAND_PATH/hyprlang/build"
    run make -C "$HYPRLAND_PATH/hyprlang/build"
    run sudo make -C "$HYPRLAND_PATH/hyprlang/build" install
    check hyprlang

    # rofi (dependencies)
    printf "rofi (dependencies)"
    check sudo apt-get install -y libgdk-pixbuf-2.0-dev libxcb-util-dev libxcb-xkb-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-cursor-dev libxcb-xinerama0-dev libstartup-notification0-dev flex bison

    # slurp (for hyprshot)
    printf "slurp (for hyprshot)"
    check sudo apt-get install -y slurp

    # wl-clipboard (for hyprshot)
    printf "wl-clipboard (for hyprshot)"
    check sudo apt-get install -y wl-clipboard

  fi

}
