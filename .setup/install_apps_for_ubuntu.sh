#!/bin/bash

install_apps() {

  # neovim
  printf "neovim"
  NEOVIM_ARCHIVE_PATH="$HOME/nvim-linux64.tar.gz"
  [ -f "$NEOVIM_ARCHIVE_PATH" ] && rm -f "$NEOVIM_ARCHIVE_PATH"
  run wget -qO "$NEOVIM_ARCHIVE_PATH" https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
  run sudo rm -rf /opt/nvim
  run sudo tar -C /opt -xzf nvim-linux64.tar.gz
  run rm -r "$NEOVIM_ARCHIVE_PATH"
  check nvim -v

  if [ "$hyprland" -eq 1 ]; then

    # gammastep
    printf "gammastep"
    check sudo apt-get install -y gammastep

    # hyprlock
    printf "hyprlock"
    HYPRLOCK_PATH="$HYPRLAND_PATH/hyprlock"
    clone_repo "https://github.com/hyprwm/hyprlock.git" "$HYPRLOCK_PATH"
    run cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S "$HYPRLOCK_PATH" -B "$HYPRLOCK_PATH/build"
    run cmake --build "$HYPRLOCK_PATH/build" --config Release --target hyprlock -j$(nproc)
    run cmake --install "$HYPRLOCK_PATH/build"
    check hyprlock

    # hyprpaper
    printf "hyprpaper\n"
    HYPRPAPER_PATH="$HYPRLAND_PATH/hyprpaper"
    clone_repo "https://github.com/hyprwm/hyprpaper.git" "$HYPRPAPER_PATH"
    run cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S "$HYPRPAPER_PATH" -B "$HYPRPAPER_PATH/build"
    run cmake --build "$HYPRPAPER_PATH/build" --config Release --target hyprpaper -j$(nproc)
    run sudo cmake --install "$HYPRPAPER_PATH/build"
    rm -f "$ERR_FILE"

    # hyprshot
    printf "hyprshot"
    HYPRSHOT_REPO_PATH="$HYPRLAND_PATH/hyprshot"
    HYPRSHOT_BIN_PATH="$HOME/.local/bin/hyprshot"
    clone_repo "https://github.com/Gustash/Hyprshot.git" "$HYPRSHOT_REPO_PATH"
    run ln -sf "$HYPRSHOT_REPO_PATH/hyprshot" "$HYPRSHOT_BIN_PATH"
    run chmod +x "$HYPRSHOT_REPO_PATH/hyprshot"
    check hyprshot

    # rofi
    printf "rofi"
    ROFI_PATH="$HYPRLAND_PATH/rofi"
    clone_repo "https://github.com/in0ni/rofi-wayland.git" "$ROFI_PATH"
    run meson setup "$ROFI_PATH" "$ROFI_PATH/build"
    run meson compile -C "$ROFI_PATH/build"
    run sudo meson install -C "$ROFI_PATH/build"
    check rofi -v

    # sway-notification-center
    printf "sway-notification-center"
    check sudo apt-get install -y sway-notification-center

    # waybar
    printf "waybar"
    check sudo apt-get install -y waybar

  fi

}
