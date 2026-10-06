_pal() { printf '%d;%d;%d' "$((16#${1:0:2}))" "$((16#${1:2:2}))" "$((16#${1:4:2}))"; }

PAL_BG=$(_pal 2E222F)
PAL_BG_ALT=$(_pal 3E3546)
PAL_CYAN=$(_pal 625565)
PAL_PLUM=$(_pal 694F62)
PAL_GREY=$(_pal 7F708A)
PAL_MAUVE=$(_pal 966C6C)
PAL_FG=$(_pal 9BABB2)
PAL_TAN=$(_pal AB947A)
PAL_WHITE=$(_pal FFFFFF)
PAL_NAVY=$(_pal 484A77)
PAL_RED=$(_pal B33831)
PAL_ORANGE=$(_pal F79617)
PAL_YELLOW=$(_pal F9C22B)
PAL_OLIVE=$(_pal A2A947)
PAL_TEAL=$(_pal 0B8A8F)
PAL_ACCENT=$(_pal A24B6F)

unset -f _pal
