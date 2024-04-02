alias emacs='emacs -nw'
alias godot='flatpak run org.godotengine.Godot'
alias browsh='sudo docker run -it browsh/browsh'
alias setup='chmod +x ~/.setup.sh && ~/.setup.sh'

# bash
alias ls='ls --color -la'
alias rm='rm -rf'
alias diff='diff --color'
alias cls='clear'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias dir='dir --color'
alias vdir='vdir --color'

# git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias dfp='/usr/bin/git --git-dir=$HOME/.dotfiles-private --work-tree=$HOME'

# fit
alias g++='g++ -std=c++20 -Wall -pedantic -Wno-long-long'
alias fray='ssh zahraon1@fray1.fit.cvut.cz'

# prusa
alias buildserver='ssh ondra@10.24.42.10'
