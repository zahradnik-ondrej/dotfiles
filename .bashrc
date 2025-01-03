# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export EDITOR=lvim

if [ -f ~/.bash_ps1 ]; then
	. ~/.bash_ps1
fi

export LS_COLORS="di=34:*.yaml=31:*.yml=31:*.ini=31:*.toml=31:*.conf=31:*.md=31:*.txt=31:*.json=31:*.pdf=31:*.doc=31:*.docx=31:*.h=32:*.sh=32:*.py=32:*.c=32:*.cpp=32:*.js=32:*.ts=32:*.lua=32:*.tar.gz=33:*.zip=33:*.stl=37:*.sl1s=37:*.sl1=37:*.3mf=37:*.gcode=37:*.bgcode=37:*.png=90:*.jpg=90:*.svg=90:*Dockerfile=36"

if [ -z "$TMUX" ]; then
	if tmux has-session 2>/dev/null; then
		tmux attach-session -d
	else
		tmux new-session -s 0
	fi
fi
