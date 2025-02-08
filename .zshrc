# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTSIZE=1000
HISTFILESIZE=2000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(< /etc/debian_chroot)
fi

if [ -f ~/.sh_aliases ]; then
  . ~/.sh_aliases
fi

autoload -Uz compinit && compinit

export EDITOR=lvim
export PATH=$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:/usr/games
export PATH=$PATH:/opt/nvim-linux64/bin
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

if [ -f ~/.zsh_ps1 ]; then
  . ~/.zsh_ps1
fi

export LS_COLORS=""
export LS_COLORS=$LS_COLORS"di=34:"
export LS_COLORS=$LS_COLORS"*.yaml=31:*.yml=31:*.ini=31:*.toml=31:*.conf=31:*.md=31:*.txt=31:*.json=31:*.pdf=31:*.doc=31:*.docx=31:"
export LS_COLORS=$LS_COLORS"*.h=32:*.sh=32:*.py=32:*.c=32:*.cpp=32:*.js=32:*.ts=32:*.lua=32:"
export LS_COLORS=$LS_COLORS"*.tar.gz=33:*.zip=33:"
export LS_COLORS=$LS_COLORS"*Dockerfile=36"
export LS_COLORS=$LS_COLORS"*.stl=37:*.sl1s=37:*.sl1=37:*.3mf=37:*.gcode=37:*.bgcode=37:*.sl2=37:*.slx=37:"
export LS_COLORS=$LS_COLORS"*.png=90:*.jpg=90:*.svg=90:"

export EZA_COLORS=""
export EZA_COLORS=$EZA_COLORS"fi=36:di=36:ln=36:pi=36:so=36:bd=36:cd=36:ex=36:"
export EZA_COLORS=$EZA_COLORS"ur=34:uw=35:ux=32:"
export EZA_COLORS=$EZA_COLORS"gr=34:gw=35:gx=32:"
export EZA_COLORS=$EZA_COLORS"tr=34:tw=35:tx=32:"

# if [ -z "$TMUX" ]; then
#   if tmux has-session 2>/dev/null; then
#     tmux attach-session -d
#   else
#     tmux new-session -s 0
#   fi
# fi

if command -v neofetch &> /dev/null; then
  echo
  neofetch
fi

if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

export NVIM_LISTEN_ADDRESS="/tmp/lvim_server"

if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v oh-my-posh &> /dev/null; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dracula.omp.yaml)"
fi
