install_themes() {

  THEMES_PATH="$HOME/.themes"
  mkdir -p "$THEMES_PATH"

  # gruvbox (for kicad)
  printf "gruvbox (for kicad)"
  KICAD_GRUVBOX_PATH="$THEMES_PATH/kicad-gruvbox"
  KICAD_THEMES_PATH="$(ls -d "$HOME"/.config/kicad/*/colors 2>/dev/null | sort -V | tail -1)"
  [ -n "$KICAD_THEMES_PATH" ] || KICAD_THEMES_PATH="$HOME/.config/kicad/colors"
  mkdir -p "$KICAD_THEMES_PATH"
  status ln -sfn "$KICAD_GRUVBOX_PATH/colors/Gruvbox.json" "$KICAD_THEMES_PATH"

  # gruvbox (for midnight-commander)
  printf "gruvbox (for midnight-commander)"
  MC_GRUVBOX_PATH="$THEMES_PATH/mc-gruvbox"
  MC_THEMES_PATH="$HOME/.local/share/mc/skins"
  mkdir -p "$MC_THEMES_PATH"
  status ln -sfn "$MC_GRUVBOX_PATH/gruvbox256.ini" "$MC_THEMES_PATH"

  # gruvbox (for vim)
  printf "gruvbox (for vim)"
  VIM_GRUVBOX_PATH="$THEMES_PATH/vim-gruvbox"
  VIM_THEMES_PATH="$HOME/.vim/pack/themes/start"
  mkdir -p "$VIM_THEMES_PATH"
  status ln -sfn "$VIM_GRUVBOX_PATH" "$HOME/.vim/pack/themes/start/gruvbox"

}
