#!/bin/sh
DDC="$HOME/.local/bin/ddc-brightness"
SAVE="${XDG_RUNTIME_DIR:-/tmp}/brightness-before-dim"

case "${1:-}" in
    --dim)
        pct=${2:-75}; pct=${pct%\%}
        case "$pct" in ''|*[!0-9]*) exit 1 ;; esac
        cur=$("$DDC" get) || exit 1
        case "$cur" in ''|*[!0-9]*) exit 1 ;; esac
        [ -f "$SAVE" ] || printf '%s\n' "$cur" > "$SAVE"
        exec "$DDC" set $(( cur * pct / 100 ))
        ;;
    --restore)
        [ -f "$SAVE" ] || exit 0
        read -r v < "$SAVE" || exit 0
        rm -f "$SAVE"
        case "$v" in ''|*[!0-9]*) exit 0 ;; esac
        exec "$DDC" set "$v"
        ;;
esac

target=""
for arg in "$@"; do
    case "$arg" in
        --fade-out|--fade-in) ;;
        *%|[0-9]*) target="${arg%\%}" ;;
    esac
done
[ -n "$target" ] || exit 1
exec "$DDC" set "$target"
