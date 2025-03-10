#!/bin/bash

install_fonts() {

  FONTS_PATH="$HOME/.local/share/fonts"

  # hack nerd font
  printf "hack nerd font"
  HACK_NERD_FONT_ARCHIVE_PATH="$HOME/Hack.zip"
  [ -f "$HACK_NERD_FONT_ARCHIVE_PATH" ] && rm -f "$HACK_NERD_FONT_ARCHIVE_PATH"
  wget -qO "$HACK_NERD_FONT_ARCHIVE_PATH" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
  mkdir -p "$FONTS_PATH"
  unzip -oq "$HACK_NERD_FONT_ARCHIVE_PATH" -d "$FONTS_PATH"
  rm -r "$HACK_NERD_FONT_ARCHIVE_PATH"

  check fc-cache -f

}
