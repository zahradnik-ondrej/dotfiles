#!/bin/bash

install_icons() {

  # papirus
  printf "papirus"
  if [ "$os" = "manjaro" ]; then
    check yay -S --needed --noconfirm papirus-icon-theme
  elif [ "$os" = "ubuntu" ]; then
    check sudo apt-get install -y papirus-icon-theme
  fi

}
