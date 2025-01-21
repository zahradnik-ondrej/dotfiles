#!/bin/bash

install_fonts() {

	FONTS_PATH="$HOME/.local/share/fonts"

	if [ "$dev_env" -eq 1 ]; then

		# hack nerd font
		printf "hack nerd font\n"
		HACK_NERD_FONT_ARCHIVE_PATH="$HOME/Hack.zip"
		[ -f "$HACK_NERD_FONT_ARCHIVE_PATH" ] && rm -f "$HACK_NERD_FONT_ARCHIVE_PATH"
		run wget -qO "$HACK_NERD_FONT_ARCHIVE_PATH" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
		run mkdir -p "$FONTS_PATH"
		run unzip -oq "$HACK_NERD_FONT_ARCHIVE_PATH" -d "$FONTS_PATH"
    run rm -r "$HACK_NERD_FONT_ARCHIVE_PATH"
    rm -f "$ERR_FILE"

	fi

  fc-cache -f

}
