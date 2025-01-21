#!/bin/bash

install_cursors() {

  CURSORS_PATH="$HOME/.cursors"
  mkdir -p "$CURSORS_PATH"

  if [ "$hyprland" -eq 1 ]; then

    # dracula (for hyprcursor)
    printf "dracula (for hyprcursor)"
    HYPRCURSOR_DRACULA_PATH="$CURSORS_PATH/hyprcursor-dracula"
    clone_repo "https://github.com/guillaumeboehm/hyprcursor_dracula_kde.git" "$HYPRCURSOR_DRACULA_PATH"
    run sudo hyprcursor-util --create "$HYPRCURSOR_DRACULA_PATH" -o "$HYPRCURSOR_DRACULA_PATH"
    run ln -sf "$HYPRCURSOR_DRACULA_PATH/theme_Dracula" "$HOME/.local/share/icons"
    rm -f "$ERR_FILE"

  fi

}
