#!/bin/bash

install_themes() {

	THEMES_PATH="$HOME/.themes"
	mkdir -p "$THEMES_PATH"

	if [ "$dev_env" -eq 1 ]; then

		# dracula (for midnight-commander)
		printf "dracula (for midnight-commander)\n"
		MC_DRACULA_PATH="$THEMES_PATH/mc-dracula"
    MC_THEMES_PATH="$HOME/.local/share/mc/skins"
		clone_repo "https://github.com/dracula/midnight-commander.git" "$MC_DRACULA_PATH"
		mkdir -p "$MC_THEMES_PATH"
		ln -sf "$MC_DRACULA_PATH/skins/dracula256.ini" "$MC_THEMES_PATH"

		# gruvbox (for vim)
		printf "gruvbox (for vim)\n"
    VIM_GRUVBOX_PATH="$THEMES_PATH/vim-gruvbox"
		VIM_THEMES_PATH="$HOME/.vim/pack/themes/start"
		clone_repo "https://github.com/morhetz/gruvbox.git" "$VIM_GRUVBOX_PATH"
		mkdir -p "$VIM_THEMES_PATH"
    ln -sf "$VIM_GRUVBOX_PATH" "$HOME/.vim/pack/themes/start/gruvbox"

	fi

  if [[ "$dev_env" -eq 1 || "$hyprland" -eq 1 ]]; then

		# dracula (for alacritty)
		printf "dracula (for alacritty)"
		ALACRITTY_DRACULA_PATH="$THEMES_PATH/alacritty-dracula"
		run clone_repo "https://github.com/dracula/alacritty.git" "$ALACRITTY_DRACULA_PATH"

  fi

	if [ "$hyprland" -eq 1 ]; then

    # dracula (for rofi)
    printf "dracula (for rofi)\n"
    ROFI_DRACULA_PATH="$THEMES_PATH/rofi-dracula"
    ROFI_THEMES_PATH="$HOME/.config/rofi"
    clone_repo "https://github.com/dracula/rofi.git" "$ROFI_DRACULA_PATH"
    mkdir -p "$ROFI_THEMES_PATH"
    ln -sf "$ROFI_DRACULA_PATH/theme/config1.rasi" "$ROFI_THEMES_PATH/config.rasi"

  fi

	if [ "$three_d" -eq 1 ]; then

		# dracula (for openscad)
		printf "dracula (for openscad)\n"
		OPENSCAD_DRACULA_PATH="$THEMES_PATH/openscad-dracula"
    OPENSCAD_THEMES_PATH="$HOME/.config/OpenSCAD/color-schemes"
		clone_repo "https://github.com/dracula/openscad.git" "$OPENSCAD_DRACULA_PATH"
		mkdir -p "$OPENSCAD_THEMES_PATH/editor" "$OPENSCAD_THEMES_PATH/render"
		ln -sf "$OPENSCAD_DRACULA_PATH/openscad/dracula.json" "$OPENSCAD_THEMES_PATH/editor"
		ln -sf "$OPENSCAD_DRACULA_PATH/openscad/transylvania.json" "$OPENSCAD_THEMES_PATH/render"

	fi

	if [ "$utilities" -eq 1 ]; then

    # dracula (for gimp)
    printf "dracula (for gimp)\n"
    GIMP_DRACULA_PATH="$THEMES_PATH/gimp-dracula"
    GIMP_THEMES_PATH="$HOME/.config/GIMP/2.10/themes"
    clone_repo "https://github.com/dracula/gimp.git" "$GIMP_DRACULA_PATH"
    mkdir -p "$GIMP_THEMES_PATH"
    ln -sf "$GIMP_DRACULA_PATH/Dracula" "$GIMP_THEMES_PATH/Dracula"

	fi

	if [ "$misc" -eq 1 ]; then

		# dracula (for telegram)
		printf "dracula (for telegram)"
    TELEGRAM_DRACULA_PATH="$THEMES_PATH/telegram-dracula"
		run clone_repo "https://github.com/dracula/telegram.git" "$TELEGRAM_DRACULA_PATH"

	fi

}
