# Tmux Cheat Sheet

## General

- **Prefix**: `Ctrl + s`
- **Reload Config File**: `<prefix> r`
- **Install Packages**: `<prefix> I`

## Clipboard

- **Copy**: `Ctrl + c`
- **Paste**: `Ctrl + Shift + v`

## Panes

- **Vertical Split**: `<prefix> v`
- **Horizontal Split**: `<prefix> h`
- **Switch Pane**: `<prefix> arrows`
- **Move Pane Left / Counter-Clockwise**: `<prefix> {`
- **Move Pane Right / Clockwise**: `<prefix> }`
- **Cycle Through Panes**: `<prefix> s`
- **Fullscreen Pane Toggle**: `<prefix> m`
- **Close Pane**: `<prefix> x`
- **Resize Pane**: `<prefix> Ctrl + arrows`
- **Clear Pane**: `<prefix> j`
- **Show Pane Numbers**: `<prefix> q`
- **Turn Pane Into Window**: `<prefix> !`

## Windows

- **New Window**: `<prefix> c`
- **Switch Window**: `<prefix> <0-9>`
- **Rename Window**: `<prefix> ,`
- **Next Window**: `<prefix> n`
- **Previous Window**: `<prefix> p`
- **Window Tree**: `<prefix> w`
- **Close Window**: `<prefix> &`
- **Toggle Between Last Two Windows**: `<prefix> l`

## Session Management

### Within Tmux

- **Detach Session**: `<prefix> d`
- **List Sessions**: `<prefix> s`
- **Kill Current Session**: `<prefix> k`
- **Rename Current Session**: `<prefix> :rename-session <new_session_name>`

### Outside Tmux

- **New Session**: `tmux` or `tmux new -s <session_name>`
- **List Sessions**: `tmux ls`
- **Attach Last Session**: `tmux a`
- **Attach Session**: `tmux a -t <session_name>`
- **Kill Specific Session**: `tmux kill-session -t <session_name>`
- **Kill All Sessions**: `tmux kill-server`

