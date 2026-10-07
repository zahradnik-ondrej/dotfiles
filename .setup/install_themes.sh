install_themes() {

  THEMES_PATH="$HOME/.themes"
  mkdir -p "$THEMES_PATH"

  # gruvbox (for kicad)
  printf "gruvbox (for kicad)"
  KICAD_GRUVBOX_PATH="$THEMES_PATH/kicad-gruvbox"
  KICAD_VERSION="$(pacman -Q kicad 2>/dev/null | awk '{split($2, v, "."); print v[1] ".0"}')"
  KICAD_THEMES_PATH="$HOME/.config/kicad/${KICAD_VERSION:-9.0}/colors"
  mkdir -p "$KICAD_THEMES_PATH"
  status ln -sfn "$KICAD_GRUVBOX_PATH/colors/Gruvbox.json" "$KICAD_THEMES_PATH"

  # gruvbox (for vim)
  printf "gruvbox (for vim)"
  VIM_GRUVBOX_PATH="$THEMES_PATH/vim-gruvbox"
  VIM_THEMES_PATH="$HOME/.vim/pack/themes/start"
  mkdir -p "$VIM_THEMES_PATH"
  status ln -sfn "$VIM_GRUVBOX_PATH" "$VIM_THEMES_PATH/gruvbox"

}
