#!/bin/bash

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
