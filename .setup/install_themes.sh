install_themes() {

  THEMES_PATH="$HOME/.themes"
  mkdir -p "$THEMES_PATH"

  # dracula (for gimp)
  printf "dracula (for gimp)"
  GIMP_DRACULA_PATH="$THEMES_PATH/gimp-dracula"
  GIMP_THEMES_PATH="$HOME/.config/GIMP/2.10/themes"
  clone_repo "https://github.com/dracula/gimp.git" "$GIMP_DRACULA_PATH"
  mkdir -p "$GIMP_THEMES_PATH"
  status ln -sf "$GIMP_DRACULA_PATH/Dracula" "$GIMP_THEMES_PATH/Dracula"

  # gruvbox (for kicad)
  printf "gruvbox (for kicad)"
  KICAD_GRUVBOX_PATH="$THEMES_PATH/kicad-gruvbox"
  KICAD_THEMES_PATH="$HOME/.config/kicad/9.0/colors"
  clone_repo "https://github.com/AlexanderBrevig/kicad-gruvbox-theme.git" "$KICAD_GRUVBOX_PATH"
  mkdir -p "$KICAD_THEMES_PATH"
  status ln -sf "$KICAD_GRUVBOX_PATH/colors/Gruvbox.json" "$KICAD_THEMES_PATH"

  # gruvbox (for midnight-commander)
  printf "gruvbox (for midnight-commander)"
  MC_GRUVBOX_PATH="$THEMES_PATH/mc-gruvbox"
  MC_THEMES_PATH="$HOME/.local/share/mc/skins"
  clone_repo "https://github.com/Dornat/midnight-commander-gruvbox-skin.git" "$MC_GRUVBOX_PATH"
  mkdir -p "$MC_THEMES_PATH"
  status ln -sf "$MC_GRUVBOX_PATH/gruvbox256.ini" "$MC_THEMES_PATH"

  # dracula (for openscad)
  printf "dracula (for openscad)"
  OPENSCAD_DRACULA_PATH="$THEMES_PATH/openscad-dracula"
  OPENSCAD_THEMES_PATH="$HOME/.config/OpenSCAD/color-schemes"
  clone_repo "https://github.com/dracula/openscad.git" "$OPENSCAD_DRACULA_PATH"
  mkdir -p "$OPENSCAD_THEMES_PATH/editor" "$OPENSCAD_THEMES_PATH/render"
  ln -sf "$OPENSCAD_DRACULA_PATH/openscad/dracula.json" "$OPENSCAD_THEMES_PATH/editor"
  status ln -sf "$OPENSCAD_DRACULA_PATH/openscad/transylvania.json" "$OPENSCAD_THEMES_PATH/render"

  # gruvbox (for telegram)
  printf "gruvbox (for telegram)"
  TELEGRAM_GRUVBOX_PATH="$THEMES_PATH/telegram-gruvbox"
  status clone_repo "https://github.com/gilbertw1/telegram-gruvbox-theme.git" "$TELEGRAM_GRUVBOX_PATH"

  # gruvbox (for vim)
  printf "gruvbox (for vim)"
  VIM_GRUVBOX_PATH="$THEMES_PATH/vim-gruvbox"
  VIM_THEMES_PATH="$HOME/.vim/pack/themes/start"
  clone_repo "https://github.com/morhetz/gruvbox.git" "$VIM_GRUVBOX_PATH"
  mkdir -p "$VIM_THEMES_PATH"
  status ln -sf "$VIM_GRUVBOX_PATH" "$HOME/.vim/pack/themes/start/gruvbox"

}
