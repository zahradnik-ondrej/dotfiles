#!/bin/bash

install_apps() {

  if [ "$os" = "manjaro" ]; then

    while IFS= read -r package; do
    printf "$package"
    check bash -c "pacman -Qi '$package' >/dev/null || yay -S --noconfirm '$package'"
    done < "${HOME}/.setup/yay-packages.txt"

    # nwg-drawer
    printf "nwg-drawer"
    NWG_DRAWER_PATH="$HOME/nwg-drawer"
    clone_repo "https://github.com/nwg-piotr/nwg-drawer.git" "$NWG_DRAWER_PATH"
    make -C "$NWG_DRAWER_PATH" get
    make -C "$NWG_DRAWER_PATH" build
    sudo make -C "$NWG_DRAWER_PATH" install

  elif [ "$os" = "ubuntu" ]; then

    while IFS= read -r package; do
      printf "$package"
      check bash -c "dpkg -l | grep -qw '$package' || sudo apt-get install -y '$package'"
    done < "${HOME}/.setup/apt-packages.txt"

    # neovim
    printf "neovim"
    NEOVIM_ARCHIVE_PATH="$HOME/nvim-linux64.tar.gz"
    [ -f "$NEOVIM_ARCHIVE_PATH" ] && rm -f "$NEOVIM_ARCHIVE_PATH"
    run wget -qO "$NEOVIM_ARCHIVE_PATH" https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    run sudo rm -rf /opt/nvim
    run sudo tar -C /opt -xzf nvim-linux64.tar.gz
    run rm -r "$NEOVIM_ARCHIVE_PATH"
    check nvim -v

  fi

  # balenaEtcher
  printf "balenaEtcher"
  install_appimage \
    "Version: effcebc" \
    "https://github.com/balena-io/etcher/releases/download/v1.18.0/balenaEtcher-1.18.0-x64.AppImage" \
    "/opt/balenaEtcher" \
    "balenaEtcher.AppImage"

  # cura
  printf "cura"
  install_appimage \
    "Version: 5735cc5" \
    "https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage" \
    "/opt/cura" \
    "cura.AppImage"

  # lunarvim
  printf "lunarvim"
  if ! command -v lvim &> /dev/null; then
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) <<< $'n\nn\nn'
    echo
  fi
  check command -v lvim

  # tpm
  printf "tpm"
  clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

  # vim-tmux-cycle
  printf "vim-tmux-cycle"
  VIM_TMUX_CYCLE_REPO_PATH="$HOME/.vim-tmux-cycle"
  VIM_TMUX_CYCLE_BIN_PATH="/usr/local/bin"
  clone_repo 'https://github.com/slarwise/vim-tmux-cycle' "$VIM_TMUX_CYCLE_REPO_PATH"
  sudo mv "$VIM_TMUX_CYCLE_REPO_PATH/vim-tmux-cycle" "$VIM_TMUX_CYCLE_BIN_PATH"
  chmod +x "$VIM_TMUX_CYCLE_BIN_PATH/vim-tmux-cycle"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "brew list --formula | grep -qw '$package' || brew install '$package'"
  done < "${HOME}/.setup/brew-packages.txt"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "cargo install --list | grep -qw '$package' || cargo install '$package'"
  done < "${HOME}/.setup/cargo-packages.txt"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "flatpak list --app | grep -qw '$package' || flatpak install -y flathub '$package'"
  done < "${HOME}/.setup/flatpak-packages.txt"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "npm list -g --depth=0 | grep -qw '$package' || sudo npm install -g '$package'"
  done < "${HOME}/.setup/npm-packages.txt"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "pip3 list | grep -qw '$package' || pip3 install --upgrade --break-system-packages '$package'"
  done < "${HOME}/.setup/pip3-packages.txt"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "pipx list | grep -qw '$package' || pipx install --quiet '$package'"
  done < "${HOME}/.setup/pipx-packages.txt"

  while IFS= read -r package; do
    printf "$package"
    check bash -c "snap list | grep -qw \"$(echo $package | awk '{print $1}')\" || sudo snap install $package"
  done < "${HOME}/.setup/snap-packages.txt"

  if [ "$os" = "manjaro" ]; then

    printf "hyprbars"
    run hyprpm add https://github.com/hyprwm/hyprland-plugins
    check hyprpm enable hyprbars

    printf "hypr-dynamic-cursors"
    run hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
    check hyprpm enable dynamic-cursors

  fi

  # rustup
  printf "rustup"
  run snap install rustup --classic
  check rustup default stable

}
