#!/bin/bash

install_packages() {
  PACKAGE_FILE="${HOME}/.setup/packages.json"

  if [ "$os" = "ubuntu" ]; then

    sudo apt-get install -y jq
    sudo apt-get install -y python3-pip
    sudo apt-get install -y pipx

  elif [ "$os" = "manjaro" ]; then

    sudo pacman -S --needed --noconfirm jq
    sudo pacman -S --needed --noconfirm npm
    sudo pacman -S --needed --noconfirm python-pip
    sudo pacman -S --needed --noconfirm python-pipx

  fi

  jq -c '.[]' "$PACKAGE_FILE" | while read -r pkg; do
    name=$(echo "$pkg" | jq -r '.name // empty')
    manager=$(echo "$pkg" | jq -r '.manager // empty')
    version=$(echo "$pkg" | jq -r '.version // empty')
    display_name=$(echo "$pkg" | jq -r '.display_name // empty')

    if [[ -z "$name" || -z "$manager" ]]; then
      echo "Skipping package due to missing name or manager: $pkg"
      continue
    fi

    case "$manager" in
      apt|yay|brew|flatpak|npm|pip3|pipx|snap|cargo)
        ;;
      *)
        echo "Skipping '$name': unknown package manager '$manager'"
        continue
        ;;
    esac

    if [[ "$os" == "manjaro" && "$manager" == "apt" ]]; then
      continue
    elif [[ "$os" == "ubuntu" && "$manager" == "yay" ]]; then
      continue
    fi

    [[ -z "$display_name" ]] && display_name="$name"

    printf "$display_name"

    case "$manager" in
      apt)
        check bash -c "dpkg -l | grep -qw '$name' || sudo apt-get install -y '$name'"
        ;;
      yay)
        check bash -c "pacman -Qi '$name' >/dev/null || yay -S --noconfirm --overwrite '*' '$name'"
        ;;
      brew)
        check bash -c "brew list --formula | grep -qw '$name' || brew install '$name'"
        ;;
      flatpak)
        check bash -c "flatpak list --app | grep -qw '$name' || flatpak install -y flathub '$name'"
        ;;
      npm)
        check bash -c "npm list -g --depth=0 | grep -qw '$name' || sudo npm install -g '$name'"
        ;;
      pip3)
        check bash -c "pip3 list | grep -qw '$name' || pip3 install --upgrade --break-system-packages '$name'"
        ;;
      pipx)
        check bash -c "pipx list | grep -qw '$name' || pipx install --quiet '$name'"
        ;;
      snap)
        check bash -c "snap list | grep -qw \"$(echo $name | awk '{print $1}')\" || sudo snap install $name"
        ;;
      cargo)
        check bash -c "cargo install --list | grep -qw '$name' || cargo install '$name'"
        ;;
    esac
  done
}
