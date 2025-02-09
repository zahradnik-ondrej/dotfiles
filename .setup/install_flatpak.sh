#!/bin/bash

install_flatpak() {

  if [ "$os" = "manjaro" ]; then

    yay -S --noconfirm flatpak

  elif [ "$os" = "ubuntu" ]; then

    sudo apt-get install -y flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

  fi

}
