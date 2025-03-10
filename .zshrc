#!/bin/bash

if [ -f ~/.shrc ]; then
  . ~/.shrc
fi

HISTFILE=~/.zsh_history

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS

autoload -Uz compinit && compinit

if [ -f ~/.zsh_ps1 ]; then
  . ~/.zsh_ps1
fi

if command -v fzf &> /dev/null; then
  eval "$(fzf --zsh)"
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

if command -v oh-my-posh &> /dev/null; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/themes/dracula.omp.yaml)"
fi

