#!/bin/bash

install_snap() {

  if [ "$os" = "manjaro" ]; then

    sudo rm -f /var/lib/pacman/db.lck
    sudo pacman -S --needed --noconfirm snapd
    sudo systemctl enable --now snapd
    sudo ln -s /var/lib/snapd/snap /snap
    sudo systemctl enable --now snapd.apparmor

  elif [ "$os" = "ubuntu" ]; then

    sudo apt-get install -y snapd

  fi

  sudo snap install core
  sudo snap refresh

}
