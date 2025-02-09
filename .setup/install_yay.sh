#!/bin/bash

install_yay() {

  if ! command -v yay &> /dev/null; then

    YAY_PATH="$HOME/.yay"
    clone_repo https://aur.archlinux.org/yay-bin.git "$YAY_PATH"
    ( cd "$YAY_PATH" && makepkg -si --noconfirm )

  fi

}
