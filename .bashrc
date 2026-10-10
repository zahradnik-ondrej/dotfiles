#!/bin/bash

if [ -f ~/.shrc ]; then
  . ~/.shrc
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

if [ -f ~/.bash_ps1 ]; then
  . ~/.bash_ps1
fi

if command -v fzf &> /dev/null; then
  eval "$(fzf --bash)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init bash)"
fi

if command -v oh-my-posh &> /dev/null; then
  eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/themes/resurrect64.omp.yaml)"
fi
