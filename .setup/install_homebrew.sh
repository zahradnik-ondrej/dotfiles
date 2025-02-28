#!/bin/bash

install_homebrew() {

  if [ "$os" = "manjaro" ]; then

    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  elif [ "$os" = "ubuntu" ]; then

    HOMEBREW_PATH="$HOME/install.sh"
    wget -qO "$HOMEBREW_PATH" https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
    NONINTERACTIVE=1 /bin/bash "$HOMEBREW_PATH"
    rm -f "$HOMEBREW_PATH"

  fi

}
