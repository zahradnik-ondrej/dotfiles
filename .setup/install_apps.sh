#!/bin/bash

install_apps() {

  if [ "$os" = "ubuntu" ]; then

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

  # arduino-ide
  printf "arduino-ide"
  install_appimage \
    "Version: effcebc" \
    "https://downloads.arduino.cc/arduino-ide/nightly/arduino-ide_nightly-20250311_Linux_64bit.AppImage" \
    "/opt/arduino-ide" \
    "arduino-ide.AppImage"

  # aseprite
  printf "aseprite"
  install_appimage \
    "Version: 8bbf694" \
    "https://cdn.humble.com/humblebundle/igara_studio_sa_bYpAP/Aseprite_1.3.13-x64.AppImage?gamekey=2xcSc7kD28qtWNrR&t=st=1743859114~exp=1743945514~hmac=312865bf783fe8d9163c6d50fe681f64c3550fe8bf6b527999cdf39756494d6d" \
    "/opt/aseprite" \
    "aseprite.AppImage"

  # # balenaEtcher
  # printf "balenaEtcher"
  # install_appimage \
  #   "Version: effcebc" \
  #   "https://github.com/balena-io/etcher/releases/download/v1.18.0/balenaEtcher-1.18.0-x64.AppImage" \
  #   "/opt/balenaEtcher" \
  #   "balenaEtcher.AppImage"

  # # cura
  # printf "cura"
  # install_appimage \
  #   "Version: 5735cc5" \
  #   "https://github.com/Ultimaker/Cura/releases/download/5.7.2-RC2/UltiMaker-Cura-5.7.2-linux-X64.AppImage" \
  #   "/opt/cura" \
  #   "cura.AppImage"

  # # lychee
  # printf "lychee"
  # install_appimage \
  #   "Version: 7.3.2" \
  #   "https://mango-lychee.nyc3.cdn.digitaloceanspaces.com/LycheeSlicer-7.3.2.AppImage" \
  #   "/opt/lychee" \
  #   "lychee-slicer.AppImage"

  # openscad
  printf "openscad"
  install_appimage \
    "AppImage runtime version: https://github.com/AppImage/type2-runtime/commit/5e7217b" \
    "https://files.openscad.org/snapshots/OpenSCAD-2025.06.03.ai25586-x86_64.AppImage" \
    "/opt/openscad" \
    "openscad.AppImage"

  # grub2-themes
  GRUB2_THEMES_PATH="$HOME/.grub2-themes"
  clone_repo "https://github.com/vinceliuice/grub2-themes.git" "$GRUB2_THEMES_PATH"

  # lunarvim
  printf "lunarvim"
  if ! command -v lvim &> /dev/null; then
    LV_BRANCH='release-1.4/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh) <<< $'n\nn\nn'
    echo
  fi
  check command -v lvim

  # tpm
  printf "tpm\n"
  clone_repo "https://github.com/tmux-plugins/tpm" "$HOME/.tmux/plugins/tpm"

  # vim-tmux-cycle
  printf "vim-tmux-cycle\n"
  VIM_TMUX_CYCLE_REPO_PATH="$HOME/.vim-tmux-cycle"
  VIM_TMUX_CYCLE_BIN_PATH="/usr/local/bin"
  clone_repo "https://github.com/slarwise/vim-tmux-cycle" "$VIM_TMUX_CYCLE_REPO_PATH"
  sudo mv "$VIM_TMUX_CYCLE_REPO_PATH/vim-tmux-cycle" "$VIM_TMUX_CYCLE_BIN_PATH"
  chmod +x "$VIM_TMUX_CYCLE_BIN_PATH/vim-tmux-cycle"

  if [ "$os" = "manjaro" ]; then

    if command -v hyprpm &>/dev/null; then

      hyprpm update > /dev/null 2>&1
  
      printf "hyprbars"
      if ! hyprpm list | grep -q hyprbars; then
        yes | hyprpm add https://github.com/hyprwm/hyprland-plugins > /dev/null 2>&1
      fi
      check hyprpm enable hyprbars
  
      printf "hypr-dynamic-cursors"
      if ! hyprpm list | grep -q dynamic-cursors; then
        yes | hyprpm add https://github.com/virtcode/hypr-dynamic-cursors > /dev/null 2>&1
      fi
      check hyprpm enable dynamic-cursors

    fi

  fi

  # rustup
  printf "rustup"
  run snap install rustup --classic
  check rustup default stable

}
